# SQL skill

Use this skill for T-SQL and Azure SQL work.

## Standards

- Prefer set-based logic over cursors
- Use SARGable predicates and appropriate indexes
- Always parameterize; never concatenate user input into SQL
- Make scripts idempotent and wrap destructive changes in transactions

## Common expectations

- explain query intent and expected cardinality
- review execution plans for slow queries
- note locking, blocking, and rollback considerations
