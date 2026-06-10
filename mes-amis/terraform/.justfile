set no-cd

# Local usage assumes `export AWS_PROFILE=monami` (or whatever your AWS
# config calls the demo account) in the calling shell. The S3 backend
# blocks intentionally don't pin a profile so CI (OIDC) and local devs
# (named profile) can share the same config.

init *PARAMS:
  terraform init {{PARAMS}}

lint:
  @terraform fmt && echo "TF formatting good."
  @terraform validate
  @tflint && echo "Linting complete."

plan *PARAMS: lint
  terraform plan {{PARAMS}}

apply *PARAMS: lint
  terraform apply {{PARAMS}}

reset:
  rm -rf .terraform*
