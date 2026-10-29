# Terraform skill

Use this skill for Terraform infrastructure and deployment work.

## Standards

- Prefer Azure Verified Modules for Terraform on Azure, with pinned versions
- Pin provider and module versions and commit the dependency lock file
- Use remote state with locking and encryption, separated per environment
- Keep resource naming predictable and environment-aware
- Mark secrets as sensitive and keep them out of code and state outputs
- Use secure defaults and least-privilege access patterns

## Common expectations

- typed, documented variables with validation where useful
- clear outputs for downstream tooling
- resource tagging and ownership conventions
- `terraform fmt`, `validate`, and a reviewed `plan` before apply
- deployment safety and idempotency
