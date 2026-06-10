variable "region" {
  description = "AWS region for the state bucket and lock table."
  type        = string
  default     = "us-west-2"
}

variable "profile" {
  description = "Named AWS profile from ~/.aws/config to authenticate with. Leave empty in CI — the AWS provider picks up OIDC creds from env vars instead."
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "S3 bucket for remote state. Must be globally unique. Defaults to monami-tfstate-<account-id>."
  type        = string
  default     = null
}

variable "project_name" {
  description = "Short name used to scope the GHA deploy role's IAM policy. Must match infra/var.project_name."
  type        = string
  default     = "monami"
}

variable "github_repo" {
  description = "GitHub org/repo authorized to assume the deploy role via OIDC, e.g. \"mes-amis/devops-terraform-exercise\"."
  type        = string
  default     = "mes-amis/devops-terraform-exercise"
}
