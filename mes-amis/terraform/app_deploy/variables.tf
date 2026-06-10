variable "region" {
  description = "AWS region to deploy into. Must match the infra stack."
  type        = string
  default     = "us-west-2"
}

variable "profile" {
  description = "Named AWS profile from ~/.aws/config to authenticate with. Leave empty in CI — the AWS provider picks up OIDC creds from env vars instead."
  type        = string
  default     = ""
}

variable "image_tag" {
  description = "ECR image tag to deploy. Must already be pushed to the infra-owned repo before apply."
  type        = string
  default     = "latest"
}

variable "task_cpu" {
  description = "Fargate task CPU units. 256 = 0.25 vCPU."
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of ECS task replicas. Ignored after creation so CI can scale without TF drift."
  type        = number
  default     = 1
}
