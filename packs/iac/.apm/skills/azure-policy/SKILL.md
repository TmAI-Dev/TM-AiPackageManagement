---
name: azure-policy
description: "Azure governance using Policy with built-in definitions, initiatives, and least-privilege assignments. Plans rollout from Audit to Deny/Modify effects. Use for Azure governance, policy design, and compliance enforcement."
---

# Azure Policy skill

Use this skill for Azure governance and policy work.

## Standards

- Prefer built-in definitions; write custom ones only when needed
- Parameterize definitions and group them into initiatives
- Roll out with Audit first, then Deny or Modify
- Use least-privilege RBAC for assignments and remediation identities

## Common expectations

- verify aliases before use
- state scope, effect, and blast radius
- document exemptions and their expiry
