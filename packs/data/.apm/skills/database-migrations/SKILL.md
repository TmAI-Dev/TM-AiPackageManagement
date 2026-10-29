# Database migrations skill

Use this skill for schema changes and database deployments.

## Standards

- Review generated SQL before applying
- Use expand/contract for backward-compatible changes
- Make scripts idempotent; back up before destructive changes
- Authenticate with managed identity, not stored credentials

## Common expectations

- stated rollback plan
- awareness of locking on large tables
- migrations applied through CI/CD, not on app startup
