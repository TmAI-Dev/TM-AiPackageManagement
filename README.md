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
├── apm.yml
├── .apm/
│   ├── agents/
│   │   ├── csharp.agent.md
│   │   ├── razor-pages.agent.md
│   │   ├── powershell.agent.md
│   │   ├── python.agent.md
│   │   ├── bicep.agent.md
│   │   ├── terraform.agent.md
│   │   ├── azure-policy.agent.md
│   │   ├── azure-devops-pipelines.agent.md
│   │   ├── sql.agent.md
│   │   ├── kusto.agent.md
│   │   ├── data-analyst.agent.md
│   │   ├── security.agent.md
│   │   ├── review.agent.md
│   │   ├── code-quality.agent.md
│   │   ├── docs.agent.md
│   │   ├── web-design.agent.md
│   │   ├── theme-consistency.agent.md
│   │   └── brainstorm.agent.md
│   └── skills/
│       ├── csharp/SKILL.md
│       ├── razor-pages/SKILL.md
│       ├── powershell/SKILL.md
│       ├── python/SKILL.md
│       ├── bicep/SKILL.md
│       ├── terraform/SKILL.md
│       ├── azure-policy/SKILL.md
│       ├── azure-devops-pipelines/SKILL.md
│       ├── sql/SKILL.md
│       ├── kusto/SKILL.md
│       ├── data-analyst/SKILL.md
│       ├── security/SKILL.md
│       ├── review/SKILL.md
│       ├── code-quality/SKILL.md
│       ├── docs/SKILL.md
│       ├── web-design/SKILL.md
│       ├── theme-consistency/SKILL.md
│       └── brainstorm/SKILL.md
├── scripts/
│   └── bootstrap-agent-pack.ps1
└── sample-target-repo/
    └── apm.yml
```

## Recommended model

Use this repository as the package source. Consumers should declare it in their own `apm.yml` and run APM.

### Shared pack

The `.apm/` directory is the package source and should always hold the common defaults:

- C# agent
- Razor Pages agent
- PowerShell agent
- Python agent
- Bicep agent
- Terraform agent
- Azure Policy agent
- Azure DevOps Pipelines agent
- SQL agent
- Kusto (KQL) agent
- Data analyst agent
- Security agent (appsec, Azure security posture, threat modeling)
- Review agent
- Code quality agent
- Docs agent
- Web Design agent
- Theme Consistency agent
- Brainstorm agent

### Repo local additions

Keep repo-specific instructions in the target repo, not in the central pack, when they depend on application-specific rules.

## Consumer setup

On Windows, install APM with the official installer:

```powershell
irm https://aka.ms/apm-windows | iex
```

Alternatively, follow the full [installation guide](https://microsoft.github.io/apm/getting-started/installation/). Then run this from the target repository:

```powershell
apm install TmAI-Dev/TM-AiPackageManagement --target copilot
```

APM will:

- add the package to `apm.yml`
- write `apm.lock.yaml` with resolved versions and hashes
- deploy agents and skills to the Copilot-supported runtime directories

Use the wrapper when installing this package into several target repositories:

```powershell
pwsh ./scripts/bootstrap-agent-pack.ps1 -TargetRepos "C:\path\to\repo-1", "C:\path\to\repo-2"
```

The wrapper requires APM to be installed and runs `apm install <package> --target copilot` in each target. It does not copy or maintain generated runtime files.

After running it, reload the VS Code window and pick the agent from the Chat agent picker. Commit `apm.yml` and `apm.lock.yaml` in each consumer repository; do not commit generated runtime files unless that repository intentionally manages them.

## Updating existing installations

To pull the latest agents and skills into a repository that already uses this package, run this from that repository:

```powershell
apm install --update --target copilot
```

This re-resolves dependencies to their latest versions and refreshes `apm.lock.yaml` and the deployed files. Review and commit the changed `apm.lock.yaml`, then reload the VS Code window.

To update several repositories at once, run the update command in each:

```powershell
"C:\path\to\repo-1", "C:\path\to\repo-2" | ForEach-Object { Push-Location $_; apm install --update --target copilot; Pop-Location }
```

If an update does not pick up new content, run `apm install --help` to confirm the flags supported by your installed APM version.

## Example agent set

The included agents are:

- C# Agent
- Razor Pages Agent
- PowerShell Agent
- Python Agent
- Bicep Agent
- Terraform Agent
- Azure Policy Agent
- Azure DevOps Pipelines Agent
- SQL Agent
- Kusto (KQL) Agent
- Data Analyst Agent
- Security Agent
- Review Agent
- Code Quality Agent
- Docs Agent
- Web Design Agent
- Theme Consistency Agent
- Brainstorm Agent

## Notes

This repository is intentionally not tied to one application. It acts as an APM package source for all your repositories.

If you later want stricter repo-level integration with other harnesses, add the corresponding APM target during installation without changing the package primitives.
