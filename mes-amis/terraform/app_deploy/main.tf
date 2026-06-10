provider "aws" {
  region  = var.region
  profile = var.profile != "" ? var.profile : null

  default_tags {
    tags = local.common_tags
  }
}

data "aws_region" "current" {}

# Cross-stack handle. infra/ owns durable plumbing (VPC, ALB, cluster, ECR,
# RDS, IAM, logs, secret); this stack pulls the IDs it needs as outputs.
# Auth follows the same env-based pattern as the backend — `AWS_PROFILE`
# locally, OIDC env vars in CI.
data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = "monami-tfstate-858656722548"
    key    = "demo/terraform.tfstate"
    region = "us-west-2"
  }
}

locals {
  infra = data.terraform_remote_state.infra.outputs

  common_tags = {
    Project     = local.infra.project_name
    Environment = local.infra.environment
    ManagedBy   = "terraform"
  }
}
