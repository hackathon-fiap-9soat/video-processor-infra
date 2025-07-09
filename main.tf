module "vpc" {
  source = "../modules/vpc"
}

module "security_groups" {
  source     = "../modules/security_groups"
  vpc_id     = module.vpc.vpc_id
}

module "kms" {
  source = "../modules/kms"
}

module "s3" {
  source   = "../modules/s3"
  kms_key_arn = module.kms.kms_key_arn
}

module "sqs" {
  source   = "../modules/sqs"
  kms_key_arn = module.kms.kms_key_arn
}

module "rds" {
  source                  = "../modules/rds"
  db_name                = var.db_name
  db_user                = var.db_user
  db_password            = var.db_password
  db_instance_class      = var.db_instance_class
  db_allocated_storage   = var.db_allocated_storage
  db_max_allocated_storage = var.db_max_allocated_storage
  subnet_ids             = module.vpc.private_subnets
  security_groups        = [module.security_groups.infra_sg_id]
  kms_key_arn            = module.kms.kms_key_arn
}

module "ecr" {
  source     = "../modules/ecr"
}

module "load_balancer" {
  source      = "../modules/load_balancer"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnets
}

module "ecs" {
  source     = "../modules/ecs"
  images_url = [
      module.ecr.repository_url_worker,
      module.ecr.repository_url_api
  ]
  execution_role_arn = var.ecs_execution_role_arn
  task_role_arn = var.ecs_task_role_arn
  subnet_ids = module.vpc.public_subnets
  security_groups_ids = var.security_groups_ids
  tg_load_balancer = module.load_balancer.target_group_arn
}

module "cognito" {
  source      = "../modules/cognito"
  environment = var.environment
  aws_region  = var.aws_region
}

module "api_gateway" {
  source         = "../modules/apigateway"
  environment    = var.environment
  target_port    = 8080
  target_ip      = module.ecs.api_task_ip
  authorizer_id  = module.cognito.api_authorizer_id
  audience       = [module.cognito.user_pool_client_id]
  issuer         = module.cognito.user_pool_issuer
  lb_dns_name    = module.load_balancer.alb_dns_name
}