output "state_bucket" {
  description = "Wire into the main stack's backend \"s3\" block as `bucket`."
  value       = aws_s3_bucket.state.id
}

output "region" {
  description = "Wire into the main stack's backend \"s3\" block as `region`."
  value       = var.region
}

output "gha_deploy_role_arn" {
  description = "Set this as `role-to-assume` on aws-actions/configure-aws-credentials in GitHub workflows."
  value       = aws_iam_role.gha_deploy.arn
}

output "github_oidc_provider_arn" {
  description = "ARN of the IAM OIDC provider trusted by token.actions.githubusercontent.com."
  value       = aws_iam_openid_connect_provider.github.arn
}
