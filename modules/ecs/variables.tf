variable "images_url" {
  description = "URLs das imagens"
  type = list(string)
}
variable "execution_role_arn" {
  description = "execution role arn"
  type        = string
}
variable "task_role_arn" {
  description = "task role arn"
  type        = string
}
variable "subnet_ids" {
    type = list(string)
}
variable "security_group_ids" {
    type = list(string)
}

variable "tg_load_balancer" {
    description = "target group arn"
    type = string
}
