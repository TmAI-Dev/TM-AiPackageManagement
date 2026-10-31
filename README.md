# Agent Package Management

This repo is an [APM](https://microsoft.github.io/apm/) package containing reusable Copilot agents and skills that can be installed into any repository.

## Goals

- Keep one authoritatively maintained set of agents and skills
- Install the same package into multiple repositories with APM
- Pin installed content with APM's lockfile and integrity checks
- Allow repo-specific additions without rewriting the shared package

## Folder layout

```text
.
├── README.md
├── apm.yml                     # metadata only; install packs, not the root
├── packs/
│   ├── core/                   # every repository
│   │   ├── apm.yml
│   │   └── .apm/
│   │       ├── agents/         # review, security, code-quality, brainstorm, docs, git-workflow, incident-troubleshooting, dependency-management
│   │       └── skills/
│   ├── iac/                    # Infrastructure as Code repositories
│   │   ├── apm.yml
│   │   └── .apm/
│   │       ├── agents/         # bicep, terraform, powershell, Azure Policy, pipelines, azure-architect, azure-cli, finops, containers, observability, migration
│   │       └── skills/
│   ├── data/                   # SQL, Kusto, and data analysis
│   │   ├── apm.yml
│   │   └── .apm/
│   │       ├── agents/         # sql, kql, data analyst, power-bi, database-migrations
│   │       └── skills/
│   └── dev/                    # application development repositories
│       ├── apm.yml
│       └── .apm/
│           ├── agents/         # csharp, Razor Pages, python, web-design, theme-consistency, testing, api-design, entra-identity, ai-integration, performance
│           └── skills/
└── sample-target-repo/
    └── apm.yml
```

## Packs

Each consumer installs only what matches its domain, so unrelated agents do not add context or confuse agent selection.

| Pack | Install path | Contents |
|---|---|---|
| core | `TmAI-Dev/TM-AiPackageManagement/packs/core` | Review, Security, Code Quality, Brainstorm, Docs, Git Workflow, Incident Troubleshooting, Dependency Management |
| iac | `TmAI-Dev/TM-AiPackageManagement/packs/iac` | Bicep (AVM-first), Terraform, PowerShell, Azure Policy, Azure DevOps Pipelines, Azure Architect, Azure CLI, FinOps, Containers, Observability, Migration |
| data | `TmAI-Dev/TM-AiPackageManagement/packs/data` | SQL, KQL (Kusto), Data Analyst, Power BI, Database Migrations |
| dev | `TmAI-Dev/TM-AiPackageManagement/packs/dev` | C#, Razor Pages, Python, Web Design, Theme Consistency, Testing, API Design, Entra Identity, AI Integration, Performance |

Typical combinations: IaC repository = `core` + `iac`; application repository = `core` + `dev`; database or monitoring repository = `core` + `data`. Combine packs freely when a repository spans domains.

Keep shared agents (review, security, code quality, brainstorm, docs, git workflow, incident troubleshooting, and dependency management) in `core` only; do not duplicate them across packs. Keep repo-specific instructions in the target repo, not in these packs.

## Consumer setup

On Windows, install APM with the official installer:

```powershell
irm https://aka.ms/apm-windows | iex
```

Alternatively, follow the full [installation guide](https://microsoft.github.io/apm/getting-started/installation/). Then run this from the target repository:

```powershell
apm install TmAI-Dev/TM-AiPackageManagement/packs/core --target copilot
apm install TmAI-Dev/TM-AiPackageManagement/packs/iac --target copilot
```

APM will:

- add the packages to `apm.yml`
- write `apm.lock.yaml` with resolved versions and hashes
- deploy agents and skills to the Copilot-supported runtime directories

Use `core` + `dev` for application repositories:

```powershell
apm install TmAI-Dev/TM-AiPackageManagement/packs/core --target copilot
apm install TmAI-Dev/TM-AiPackageManagement/packs/dev --target copilot
```

After installing, reload the VS Code window and pick the agent from the Chat agent picker.

Following APM's recommendations, in each consumer repository:

- Commit `apm.yml`, `apm.lock.yaml`, and the deployed agent and skill files (for example under `.github/`), so they are reviewable and available after clone and to CI.
- Add `apm_modules/` to `.gitignore`; it is derived and restored by `apm install`.
- Pin `targets:` in `apm.yml` (see [sample-target-repo/apm.yml](sample-target-repo/apm.yml)) so every machine deploys to the same harnesses.
- On a fresh clone, run `apm install` to restore `apm_modules/`. In CI, use `apm install --frozen` to fail on lockfile drift.

To keep the packs out of a repository instead, install them at user scope with `apm install -g <pack>`.

## Updating existing installations

To pull the latest agents and skills into a repository that already uses this package, run this from that repository:

```powershell
apm install --update --target copilot
```

This re-resolves dependencies to their latest versions and refreshes `apm.lock.yaml` and the deployed files. Review and commit the changed `apm.lock.yaml` and deployed files, then reload the VS Code window.

To update several repositories at once, run the update command in each:

```powershell
"C:\path\to\repo-1", "C:\path\to\repo-2" | ForEach-Object { Push-Location $_; apm install --update --target copilot; Pop-Location }
```

If an update does not pick up new content, run `apm install --help` to confirm the flags supported by your installed APM version.
