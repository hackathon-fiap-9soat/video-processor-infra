output "repository_url_worker" {
  value = aws_ecr_repository.video_processor.repository_url
}

output "repository_url_api" {
  value = aws_ecr_repository.video_processor_api.repository_url
}