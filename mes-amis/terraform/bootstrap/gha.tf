# GitHub Actions OIDC trust. Lets workflows in `var.github_repo` assume
# `gha_deploy` without any long-lived AWS keys stored in GitHub secrets.

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

data "aws_iam_policy_document" "gha_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    # Scope to this repo. `:*` allows any branch/PR; tighten to
    # `repo:.../<repo>:ref:refs/heads/main` if you want apply restricted
    # to main only (PRs do plan-only, which is read-mostly anyway).
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repo}:*"]
    }
  }
}

resource "aws_iam_role" "gha_deploy" {
  name               = "monami-gha-deploy"
  assume_role_policy = data.aws_iam_policy_document.gha_assume.json
  description        = "Assumed by GitHub Actions via OIDC to plan/apply Terraform and push images."
}

# PowerUserAccess covers everything the stacks touch (VPC, ECS, ECR, RDS,
# ALB, Secrets Manager, CloudWatch, S3) except IAM. IAM is granted below,
# scoped to the project's role naming pattern.
resource "aws_iam_role_policy_attachment" "gha_deploy_power" {
  role       = aws_iam_role.gha_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

data "aws_iam_policy_document" "gha_deploy_iam" {
  # Role lifecycle for the task execution / task roles created by infra/.
  statement {
    actions = [
      "iam:GetRole",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:UpdateRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:ListRoleTags",
      "iam:PassRole",
      "iam:GetRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:ListInstanceProfilesForRole",
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.project_name}-*",
    ]
  }

  # Read-only IAM bits TF needs at plan time.
  statement {
    actions = [
      "iam:ListPolicies",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicyVersions",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "gha_deploy_iam" {
  name   = "iam-management"
  role   = aws_iam_role.gha_deploy.id
  policy = data.aws_iam_policy_document.gha_deploy_iam.json
}
