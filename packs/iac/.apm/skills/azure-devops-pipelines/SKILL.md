---
name: azure-devops-pipelines
description: "CI/CD pipelines using Azure DevOps YAML and GitHub Actions with OIDC authentication and secure deployment gates. Separates build, validate, and deploy stages. Use for pipeline design, CI/CD setup, and deployment automation."
---

# Azure DevOps Pipelines skill

Use this skill for Azure DevOps YAML pipelines and GitHub Actions.

## Standards

- Use templates and parameters for reuse
- Separate build, validate, and deploy stages
- Use OIDC / workload identity federation instead of stored secrets
- Gate production with environment approvals

## Common expectations

- Bicep what-if or Terraform plan reviewed before apply
- path and branch filters on triggers
- pinned task and action versions
- secrets never written to logs
