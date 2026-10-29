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
│   │       ├── agents/         # review, security, code-quality, brainstorm
│   │       └── skills/
│   ├── iac/                    # Infrastructure as Code repositories
│   │   ├── apm.yml
│   │   └── .apm/
│   │       ├── agents/         # bicep, powershell
│   │       └── skills/
│   └── dev/                    # application development repositories
│       ├── apm.yml
│       └── .apm/
│           ├── agents/         # csharp, python, web-design, theme-consistency
│           └── skills/
├── scripts/
│   └── bootstrap-agent-pack.ps1
└── sample-target-repo/
    └── apm.yml
```

## Packs

Each consumer installs only what matches its domain, so unrelated agents do not add context or confuse agent selection.

| Pack | Install path | Contents |
|---|---|---|
| core | `TmAI-Dev/TM-AiPackageManagement/packs/core` | Review, Security, Code Quality, Brainstorm |
| iac | `TmAI-Dev/TM-AiPackageManagement/packs/iac` | Bicep (AVM-first), PowerShell |
| dev | `TmAI-Dev/TM-AiPackageManagement/packs/dev` | C#, Python, Web Design, Theme Consistency |

Typical combinations: IaC repository = `core` + `iac`; application repository = `core` + `dev`.

Keep shared agents (review, security) in `core` only; do not duplicate them across packs. Keep repo-specific instructions in the target repo, not in these packs.
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

Use the wrapper when installing packs into several target repositories (`-Packs` defaults to `core`):

```powershell
pwsh ./scripts/bootstrap-agent-pack.ps1 -TargetRepos "C:\path\to\iac-repo" -Packs core, iac
pwsh ./scripts/bootstrap-agent-pack.ps1 -TargetRepos "C:\path\to\app-repo" -Packs core, dev
```

The wrapper requires APM to be installed and runs `apm install <repository>/packs/<pack> --target copilot` for each pack in each target. It does not copy or maintain generated runtime files.

After running it, reload the VS Code window and pick the agent from the Chat agent picker. Commit `apm.yml` and `apm.lock.yaml` in each consumer repository; do not commit generated runtime files unless that repository intentionally manages them.

## Notes

This repository is intentionally not tied to one application. It acts as an APM package source for all your repositories, split into packs by domain.

If you later want stricter repo-level integration with other harnesses, add the corresponding APM target during installation without changing the package primitives.
