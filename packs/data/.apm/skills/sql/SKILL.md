# SQL skill

Use this skill for SQL queries, schema design, and database changes.

## Standards

- State the dialect (T-SQL by default) and keep to it
- Use parameterized queries; never build SQL from user input
- Select named columns, use explicit joins, and keep predicates sargable
- Enforce integrity with keys, constraints, and transactions
- Use least-privilege roles and keep secrets out of scripts

## Common expectations

- idempotent, reversible migrations
- warnings before destructive statements
- indexes justified by query patterns and checked against execution plans
- set-based logic over row-by-row processing
