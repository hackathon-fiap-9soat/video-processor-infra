output "ecs_service_name_worker" {
  value = aws_ecs_service.worker.name
}

output "ecs_service_name_api" {
  value = aws_ecs_service.api.name
}

output "api_task_ip" {
  value = data.aws_network_interface.api_eni[0].association[0].public_ip
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}