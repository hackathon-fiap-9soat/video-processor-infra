output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "IDs das subnets privadas"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "IDs das subnets publicas"
}

output "vpc_id" {
  description = "ID da VPC"
  value       = module.vpc.vpc_id
}