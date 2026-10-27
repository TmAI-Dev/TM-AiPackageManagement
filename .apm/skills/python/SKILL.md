# Python skill

Use this skill for Python application, API, script, and library work.

## Standards

- Follow PEP 8 and use type hints on public functions
- Use virtual environments and pinned dependencies
- Keep functions small and testable; test with pytest
- Use context managers for resources
- Log with `logging`, not `print`

## Security

- Validate and sanitize all external input
- Never hard-code secrets; use environment variables or a secret store
- Use parameterized queries and avoid `shell=True`
- Avoid `eval`, `exec`, and unsafe deserialization (`pickle`, `yaml.load`)
- Audit dependencies (for example with `pip-audit`)
