variable "target_ip" {
  description = "IP público da task ECS da API"
  type        = string
}

variable "target_port" {
  description = "Porta do container ECS (API)"
  type        = number
}

variable "environment" {
  description = "Ambiente de execução"
  type        = string
}

variable "authorizer_id" {
  description = "ID do JWT Authorizer"
  type        = string
  default     = ""
}

variable "audience" {
  type        = list(string)
  description = "Lista de audiences do JWT (client_id do Cognito)"
  default     = []
}

variable "issuer" {
  type        = string
  description = "Issuer do JWT (URL do Cognito)"
  default     = ""
}

variable "lb_dns_name" {
  type        = string
  description = "load balancer dns name"
  default     = ""
}