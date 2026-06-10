output "name_prefix" {
  description = "`project-environment` string used to name and tag every resource. Reused by app_deploy."
  value       = local.name_prefix
}

output "project_name" {
  description = "Project tag value, re-exported so app_deploy can stamp the same default_tags."
  value       = var.project_name
}

output "environment" {
  description = "Environment tag value, re-exported so app_deploy can stamp the same default_tags."
  value       = var.environment
}

output "region" {
  description = "AWS region the stack is deployed in."
  value       = data.aws_region.current.region
}

output "alb_dns_name" {
  description = "Public DNS of the ALB. Hit this with curl to reach the app."
  value       = aws_lb.main.dns_name
}

output "alb_target_group_arn" {
  description = "Target group the ECS service registers tasks against."
  value       = aws_lb_target_group.app.arn
}

output "alb_listener_arn" {
  description = "HTTP listener ARN. app_deploy doesn't reference this directly but it's handy for ad-hoc lookups."
  value       = aws_lb_listener.http.arn
}

output "ecr_repository_url" {
  description = "Push container images here, then redeploy the ECS service."
  value       = aws_ecr_repository.app.repository_url
}

output "ecs_cluster_id" {
  description = "ECS cluster ID (ARN). Used as the `cluster` field on the service."
  value       = aws_ecs_cluster.main.id
}

output "ecs_cluster_name" {
  description = "ECS cluster hosting the app service."
  value       = aws_ecs_cluster.main.name
}

output "private_subnet_ids" {
  description = "Private subnets ECS tasks run in."
  value       = aws_subnet.private[*].id
}

output "tasks_security_group_id" {
  description = "Security group attached to ECS tasks. Allows ALB ingress and outbound to AWS APIs / RDS."
  value       = aws_security_group.tasks.id
}

output "task_execution_role_arn" {
  description = "Role assumed by the ECS agent (image pull, log writes, secret fetch)."
  value       = aws_iam_role.task_execution.arn
}

output "task_role_arn" {
  description = "Role assumed by the running container."
  value       = aws_iam_role.task.arn
}

output "log_group_name" {
  description = "CloudWatch log group the task writes to."
  value       = aws_cloudwatch_log_group.app.name
}

output "container_port" {
  description = "Port the container listens on. Single source of truth for app_deploy."
  value       = var.container_port
}

output "db_endpoint" {
  description = "RDS Postgres endpoint (host:port). Private — only reachable from inside the VPC."
  value       = aws_db_instance.main.endpoint
}

output "database_url_secret_arn" {
  description = "ARN of the Secrets Manager secret holding DATABASE_URL."
  value       = aws_secretsmanager_secret.database_url.arn
}
