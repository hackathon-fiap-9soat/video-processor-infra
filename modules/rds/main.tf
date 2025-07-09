resource "aws_db_instance" "postgres" {
  allocated_storage      = var.db_allocated_storage
  max_allocated_storage  = var.db_max_allocated_storage
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.db_user
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = var.security_groups
  storage_encrypted      = true
  kms_key_id             = var.kms_key_arn
  publicly_accessible    = false
  skip_final_snapshot    = true
  backup_retention_period = var.db_backup_retention_period
  deletion_protection     = false
  multi_az                = var.multi_az
  auto_minor_version_upgrade = true
  apply_immediately         = true
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids
}