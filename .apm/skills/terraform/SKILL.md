# Terraform skill

Use this skill for Azure infrastructure work with Terraform.

## Standards

- Pin Terraform and provider versions
- Use modules with explicit variables and outputs
- Use remote state in Azure Storage with locking
- Prefer `for_each` over `count` for stable resource identity
- Mark sensitive values; keep secrets out of state and tfvars

## Common expectations

- `terraform fmt`, `validate`, and `plan` reviewed before apply
- consistent naming and tagging
- OIDC authentication for pipelines
- replacement and data-loss risks called out
