---
name: sql
description: "SQL specialist for schema design, query writing, tuning, and safe database changes. Covers parameterized queries, indexed performance, migrations, and T-SQL (portable where possible). Use for SQL queries, schema design, query optimization, and database changes."
---

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
