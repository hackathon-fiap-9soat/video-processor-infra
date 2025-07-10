resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "videos" {
  bucket        = "videos-hackathon-${random_id.bucket_id.hex}"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.videos.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}