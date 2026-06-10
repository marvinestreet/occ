output "ecs_service_name" {
  description = "Name of the ECS service. Use with `aws ecs update-service --force-new-deployment` to redeploy without a TF apply."
  value       = aws_ecs_service.app.name
}

output "task_definition_arn" {
  description = "ARN (with revision) of the active task definition."
  value       = aws_ecs_task_definition.app.arn
}

output "image" {
  description = "Resolved image reference baked into the current task definition."
  value       = "${local.infra.ecr_repository_url}:${var.image_tag}"
}

output "alb_url" {
  description = "Public URL of the app. Passthrough from infra so you can grab it after an app_deploy apply."
  value       = "http://${local.infra.alb_dns_name}"
}
