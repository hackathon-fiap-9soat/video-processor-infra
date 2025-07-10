module "vpc" {
  source = "./modules/vpc"
}

module "security_groups" {
  source     = "./modules/security_groups"
  vpc_id     = module.vpc.vpc_id
}

module "kms" {
  source = "./modules/kms"
}

module "s3" {
  source   = "./modules/s3"
  kms_key_arn = module.kms.kms_key_arn
}

module "sqs" {
  source   = "./modules/sqs"
  kms_key_arn = module.kms.kms_key_arn
}

module "rds" {
  source                    = "./modules/rds"
  db_identifier             = "video-processor-db"
  db_username               = "postgres"
  db_password               = "12345678"
  db_instance_class         = "db.t3.micro"
  db_allocated_storage      = 5
  db_max_allocated_storage  = 20
  subnet_ids                = module.vpc.private_subnets
  security_group_ids        = [module.security_groups.infra_sg_id]
  kms_key_id                = module.kms.kms_key_arn
}

module "ecr" {
  source     = "./modules/ecr"
}

module "load_balancer" {
  source      = "./modules/load_balancer"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnets
}

module "ecs" {
  source     = "./modules/ecs"
  images_url = [
      module.ecr.repository_url_worker,
      module.ecr.repository_url_api
  ]
  subnet_ids = module.vpc.public_subnets
  security_group_ids = [module.security_groups.infra_sg_id]
  tg_load_balancer = module.load_balancer.target_group_arn
}

module "cognito" {
  source      = "./modules/cognito"
  aws_region  = "us-east-1"
}

module "api_gateway" {
  source         = "./modules/apigateway"
  target_port    = 8080
  target_ip      = module.ecs.api_task_ip
  audience       = [module.cognito.user_pool_client_id]
  issuer         = module.cognito.user_pool_issuer
  lb_dns_name    = module.load_balancer.alb_dns_name
}