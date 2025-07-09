resource "aws_security_group" "infra_sg" {
  name        = "infra_sg"
  description = "Grupo de seguranca para infra"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Permite acesso apenas dentro da VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Permite tráfego de saída
    cidr_blocks = ["0.0.0.0/0"]  # Permite tráfego de saída para qualquer lugar
  }
}
