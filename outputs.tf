output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "sqs_queue_url" {
  value = module.sqs.queue_url
}



output "rds_endpoint" {
  value = module.rds.endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}