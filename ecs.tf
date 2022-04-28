resource "aws_ecs_cluster" "main" {
  name = "${var.application_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_cloudwatch_log_group" "logs" {
  name              = "${var.application_name}-log-group"
  retention_in_days = var.logs_retention_in_days
}


resource "aws_ecs_task_definition" "main" {
  family                            = var.application_name
  network_mode                      = "awsvpc"
  requires_compatibilities          = ["FARGATE"]
  cpu                               = var.fargate_cpu
  memory                            = var.fargate_memory
  execution_role_arn                = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn                     = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode(
  [
    {
      "name" : "${var.environment}-${var.application_name}-container",
      "image" : var.image_to_deploy,
      "networkMode" : "awsvpc",
      "essential" : true,
      "readonlyRootFilesystem" : var.read_only_filesystem,
      "portMappings" : [
        {
          "protocol" : "tcp", # The only allowed values are tcp or udp
          "containerPort" : var.main_app_port,
          "hostPort" : var.main_app_port
        }
      ],
      "environment" : [
        {
          "name" = "NGINX_PORT",
          "value" = var.main_app_port
        }
      ],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : aws_cloudwatch_log_group.logs.name,
          "awslogs-region" : var.region,
          "awslogs-stream-prefix" : "${var.application_name}-logstream"
        }
      }

    }
  ]
  )
}

resource "aws_ecs_service" "main" {
  name            = "${var.application_name}-fargate-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.container_count
  launch_type     = "FARGATE"
  health_check_grace_period_seconds = var.health_check_grace_period
  force_new_deployment = var.force_new_deploy

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.aws_subnet_ids.private.ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.main.id
    container_name   = "${var.environment}-${var.application_name}-container"
    container_port   = var.fargate_port
  }

  deployment_circuit_breaker {
    enable = true
    rollback = true
  }

}
