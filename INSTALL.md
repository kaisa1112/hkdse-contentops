# Install HKDSE ContentOps

The same UTF-8 skill files work in Codex and Claude on Windows, macOS, and Linux. No runtime dependency is required for content generation; the host supplies its own web and social research tools.

## macOS and Linux

Install for both hosts:

```sh
./scripts/install-skill.sh --target both
```

Install for one host:

```sh
./scripts/install-skill.sh --target codex
./scripts/install-skill.sh --target claude
```

## Windows PowerShell

Install for both hosts:

```powershell
.\scripts\install-skill.ps1 -Target both
```

Install for one host:

```powershell
.\scripts\install-skill.ps1 -Target codex
.\scripts\install-skill.ps1 -Target claude
```

If the destination already exists, the installer stops. Use `--force` or `-Force` only when replacement is intended; the previous directory is moved to a timestamped backup first.

## Default user-level destinations

| Host | macOS/Linux | Windows |
|---|---|---|
| Codex | `~/.codex/skills/hkdse-contentops` | `%USERPROFILE%\.codex\skills\hkdse-contentops` |
| Claude | `~/.claude/skills/hkdse-contentops` | `%USERPROFILE%\.claude\skills\hkdse-contentops` |

For project-level Claude use, copy `plugins/hkdse-contentops/skills/hkdse-contentops` to `<project>/.claude/skills/hkdse-contentops`.

## Codex plugin mode

The repository also contains a valid Codex plugin manifest and marketplace entry. From a local checkout, add the repository as a local marketplace and install the plugin:

```sh
codex plugin marketplace add /absolute/path/to/hkdse-contentops
codex plugin add hkdse-contentops@hkdse-contentops
```

After installation or upgrade, start a new Codex task or Claude session so the host reloads the skill.
