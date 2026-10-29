# KQL skill

Use this skill for Kusto Query Language queries in Azure Monitor, Log Analytics, Application Insights, Azure Data Explorer, and Sentinel.

## Standards

- Filter on time first, then other predicates, before joins and aggregations
- Project only the columns you need, as early as possible
- Prefer `has` over `contains`, and avoid `search *` on large tables
- Use `let` for reusable values and sub-queries
- Verify table and column names for the target service before use

## Common expectations

- `summarize` with `bin()` for time series, `render` for visualization
- explicit join kinds, with the smaller table on the left
- cheap, deterministic alert queries
- no sensitive data or secrets in query text
