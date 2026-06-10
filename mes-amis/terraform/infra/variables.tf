variable "region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-west-2"
}

variable "profile" {
  description = "Named AWS profile from ~/.aws/config to authenticate with. Leave empty in CI — the AWS provider picks up OIDC creds from env vars instead."
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Short name used to prefix and tag every resource."
  type        = string
  default     = "monami"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod). Used in tags and resource names."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of AZs to spread subnets across. Two is the practical minimum for an ALB."
  type        = number
  default     = 2
}

variable "container_port" {
  description = "Port the Sinatra app listens on inside the container. ALB target group and tasks SG are both built around this; the app_deploy stack reads it back via remote state."
  type        = number
  default     = 4567
}

variable "db_name" {
  description = "Initial Postgres database name."
  type        = string
  default     = "monami"
}

variable "db_username" {
  description = "Postgres master username."
  type        = string
  default     = "monami"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "RDS storage size in GiB."
  type        = number
  default     = 20
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days."
  type        = number
  default     = 7
}
