terraform {
  required_version = ">= 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.49.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.9"
    }
  }

  # No `profile` here — backends only take literal values. Locally,
  # `export AWS_PROFILE=monami` before running terraform; in CI the OIDC
  # role provides creds via env vars.
  backend "s3" {
    bucket       = "monami-tfstate-858656722548"
    key          = "demo/terraform.tfstate"
    region       = "us-west-2"
    use_lockfile = true
    encrypt      = true
  }
}
