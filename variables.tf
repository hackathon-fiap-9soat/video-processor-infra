variable "db_password" {
  description = "Senha do banco"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Ambiente de deploy (dev, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ElastiCache"
  type        = list(string)
}

variable "k8s_cidr_blocks" {
  description = "CIDR blocks from which K8s cluster pods/ nodes can access Redis"
  type        = list(string)
  default     = []
}
