resource "aws_ecr_repository" "video_processor" {
  name                 = "video-processor"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  encryption_configuration {
    encryption_type = "AES256"
  }

}

resource "aws_ecr_repository" "video_processor_api" {
  name                 = "video-processor-api"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  encryption_configuration {
    encryption_type = "AES256"
  }

}