# Kusto skill

Use this skill for KQL queries across Log Analytics, Application Insights, Resource Graph, and Azure Data Explorer.

## Standards

- Always bound queries by time range
- Filter early, then `project` only needed columns
- Confirm table and column names before relying on them
- Comment non-trivial steps

## Common expectations

- note syntax differences between Log Analytics, Resource Graph, and ADX
- keep alert and workbook queries cheap and stable
- explain what the query returns
