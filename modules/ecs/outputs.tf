output "ecs_service_name_worker" {
  value = aws_ecs_service.worker.name
}

output "ecs_service_name_api" {
  value = aws_ecs_service.api.name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}