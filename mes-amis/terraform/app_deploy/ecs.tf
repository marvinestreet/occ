resource "aws_ecs_task_definition" "app" {
  family                   = "${local.infra.name_prefix}-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = local.infra.task_execution_role_arn
  task_role_arn            = local.infra.task_role_arn

  container_definitions = jsonencode([{
    name      = "app"
    image     = "${local.infra.ecr_repository_url}:${var.image_tag}"
    essential = true

    portMappings = [{
      containerPort = local.infra.container_port
      hostPort      = local.infra.container_port
      protocol      = "tcp"
    }]

    environment = [{
      name  = "PERMITTED_HOSTS"
      value = local.infra.alb_dns_name
    }]

    secrets = [{
      name      = "DATABASE_URL"
      valueFrom = local.infra.database_url_secret_arn
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = local.infra.log_group_name
        awslogs-region        = data.aws_region.current.region
        awslogs-stream-prefix = "app"
      }
    }
  }])
}

resource "aws_ecs_service" "app" {
  name            = "${local.infra.name_prefix}-app"
  cluster         = local.infra.ecs_cluster_id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = local.infra.private_subnet_ids
    security_groups  = [local.infra.tasks_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = local.infra.alb_target_group_arn
    container_name   = "app"
    container_port   = local.infra.container_port
  }

  lifecycle {
    # Let CI update the task def (image_tag) without TF flapping desired_count.
    ignore_changes = [desired_count]
  }
}
