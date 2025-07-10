resource "aws_ecs_cluster" "main" {
  name = "video-processor-cluster"
}


resource "aws_ecs_task_definition" "worker" {
  family                   = "video-processor-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = "arn:aws:iam::553859338902:role/LabRole"

  container_definitions = jsonencode([
    {
      name      = "video-processor"
      image     = var.images_url[0]
      portMappings = [
        {
          containerPort = 8080
          protocol       = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "worker" {
  name            = "video-processor-service"
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  desired_count   = 1
  task_definition = aws_ecs_task_definition.worker.arn

  network_configuration {
    subnets = var.subnet_ids
    security_groups  = var.security_group_ids
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_ecs_task_definition" "api" {
  family                   = "video-processor-api-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = "arn:aws:iam::553859338902:role/LabRole"

  container_definitions = jsonencode([
    {
      name      = "video-processor-api"
      image     = var.images_url[1]
      portMappings = [
        {
          containerPort = 8080
          protocol       = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "api" {
  name            = "video-processor-api-service"
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  desired_count   = 1
  task_definition = aws_ecs_task_definition.api.arn

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = var.security_group_ids
  }

  load_balancer {
    target_group_arn = var.tg_load_balancer
    container_name   = "video-processor-api"
    container_port   = 8080
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}
