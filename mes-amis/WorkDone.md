# mes-amis Project Summary

## Overview

This is a DevOps interview exercise deploying a Ruby web app to AWS using Terraform and ECS. The work was done entirely on June 8, 2026 across 8 commits.

The project built out the full infrastructure-as-code for a containerized Ruby app on AWS, then wired up GitHub Actions CI/CD pipelines, and finished by completing the exercise checklist.

---

## Files Changed

**Documentation**
- `DevOps Interview AWS Exercise.md` — exercise spec/checklist, updated across three commits (initial, progress check-offs, formatting)

**Application**
- `app.rb` — Ruby app, modified twice (mid-build check-in + permissions fix)

**GitHub Actions (new)**
- `.github/workflows/deploy.yml`
- `.github/workflows/terraform.yml`
- `.github/workflows/test.yml`

**Ruby**
- `.ruby-version`
- `Gemfile.lock`
- `test/test_helper.rb`

**Terraform — Bootstrap**
- `terraform/bootstrap/main.tf`, `outputs.tf`, `variables.tf`, `versions.tf`
- `terraform/bootstrap/gha.tf` — new; GHA OIDC/IAM setup
- `terraform/bootstrap/.terraform.lock.hcl`
- `terraform/bootstrap/TF_PLAN` — deleted

**Terraform — Infra (renamed from `deploy/`)**
- `terraform/infra/alb.tf`, `ecr.tf`, `ecs.tf`, `iam.tf`, `logs.tf`, `outputs.tf`, `rds.tf`, `secrets.tf`, `security_groups.tf`, `vpc.tf`
- `terraform/infra/main.tf`, `variables.tf`, `versions.tf`
- `terraform/infra/.terraform.lock.hcl`

**Terraform — App Deploy (split out from infra)**
- `terraform/app_deploy/main.tf`, `variables.tf`, `versions.tf`, `ecs.tf`, `outputs.tf`
- `terraform/app_deploy/.terraform.lock.hcl`

**Other**
- `terraform/.justfile`
- `terraform/.tflint.hcl`
- `.gitignore`

---

## Progression

1. **Initial scaffolding** — gitignore, exercise doc, bootstrap Terraform, skeleton deploy module
2. **Infrastructure build-out** — ALB, ECR, ECS, IAM, RDS, VPC, security groups, secrets, logs
3. **Terraform restructure** — split `deploy/` into separate `infra/` (shared resources) and `app_deploy/` (ECS service deployment) modules
4. **App permissions fix** — corrected Ruby app permissions issues
5. **GHA CI/CD setup** (#1 PR) — three workflows (test, terraform plan/apply, deploy), OIDC auth for GHA→AWS, provider hash fixes, platform locks, test helper allowlist fix
6. **Exercise completion** — checked off deliverables in the exercise doc
