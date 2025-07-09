variable "db_identifier" {
  description = "Identificador da instância RDS"
  type        = string
}

variable "db_instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Espaço inicial da instância RDS"
  type        = number
  default     = 5
}

variable "db_max_allocated_storage" {
  description = "Espaço máximo que o banco pode escalar"
  type        = number
  default     = 10
}

variable "db_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
  default     = "fastfood"
}

variable "db_username" {
  description = "Usuário do banco"
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

variable "kms_key_id" {
  description = "ID da chave KMS para criptografia"
  type        = string
}

variable "db_backup_retention_period" {
  type        = number
  default     = 1
  description = "Número de dias para manter backups automáticos"
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Ativar instância multi-AZ (alta disponibilidade)"
}
