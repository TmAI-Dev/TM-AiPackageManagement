# Containers skill

Use this skill for container images and container hosting on Azure.

## Standards

- Multi-stage builds with minimal, pinned base images
- Run as non-root; no secrets in images
- Define health probes and resource limits
- Use managed identity for ACR pulls

## Common expectations

- vulnerability scanning in CI and ACR
- clear scaling and ingress configuration
- Container Apps preferred unless Kubernetes features are required
