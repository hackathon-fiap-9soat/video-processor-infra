resource "aws_sqs_queue" "video_queue" {
  name                              = "video-processing-queue"
  kms_master_key_id                 = var.kms_key_arn
  kms_data_key_reuse_period_seconds = 300
  message_retention_seconds         = 604800
  redrive_policy = jsonencode({
      deadLetterTargetArn = aws_sqs_queue.video_dlq.arn
      maxReceiveCount     = 5
    })
}

resource "aws_sqs_queue" "video_dlq" {
  name = "video-processing-dlq"
}
