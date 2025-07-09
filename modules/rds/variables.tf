variable "db_identifier" {
  description = "Nome do banco de dados"
  type        = string
}

variable "db_instance_class" {
  description = "Classe da instancia RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Espaco inicial do banco de dados"
  type        = number
  default     = 5
}

variable "db_max_allocated_storage" {
  description = "Espaco maximo que o banco pode escalar"
  type        = number
  default     = 10
}

variable "db_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
  default     = "fastfood"
}

variable "db_username" {
  description = "Usuario do banco"
  type        = string
}

variable "db_password" {
  description = "Senha do banco"
  type        = string
  sensitive   = true
}

variable "security_group_ids" {
  description = "Lista de IDs dos security groups"
  type        = list(string)
}

variable "subnet_ids" {
  description = "Lista de subnets para o RDS"
  type        = list(string)
}

variable "environment" {
  description = "Ambiente de deploy (dev, prod)"
  type        = string
}

variable "kms_key_id" {
  description = "ID da chave KMS para criptografia"
  type        = string
}