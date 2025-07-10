variable "target_port" {
  description = "Porta do container ECS (API)"
  type        = number
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