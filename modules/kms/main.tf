resource "aws_kms_key" "video_kms" {
  description             = "KMS key for encrypting video infra"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}
