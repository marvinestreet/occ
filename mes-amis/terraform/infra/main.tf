provider "aws" {
  region  = var.region
  profile = var.profile != "" ? var.profile : null

  default_tags {
    tags = local.common_tags
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

# data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  name_prefix = "${var.project_name}-${var.environment}"

  azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
