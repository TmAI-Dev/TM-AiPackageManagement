# Entra identity skill

Use this skill for authentication, authorization, and identity configuration.

## Standards

- Prefer managed identities and federated credentials over secrets
- Request least-privilege permissions
- Validate tokens fully; use Microsoft.Identity.Web or MSAL rather than custom code
- Never log or commit tokens or secrets

## Common expectations

- authorization code with PKCE for user sign-in
- clear notes on admin consent and RBAC assignments
- app roles or groups for authorization
