# Install Hong Kong Diploma of Secondary Education Examination ContentOps for Codex

Short name / 简称：**HKDSE ContentOps**

The UTF-8 skill files install into Codex. macOS is the primary validated environment; Windows and Linux installers remain available for environment-specific testing. Content generation has no bundled runtime dependency because Codex supplies the available web and social research tools.

## macOS and Linux

```sh
./scripts/install-skill.sh
```

## Windows PowerShell

```powershell
.\scripts\install-skill.ps1
```

If the destination already exists, the installer stops. Use `--force` or `-Force` only when replacement is intended; the previous directory is moved to a timestamped backup first.

## Default user-level destinations

| macOS/Linux | Windows |
|---|---|
| `~/.codex/skills/hkdse-contentops` | `%USERPROFILE%\.codex\skills\hkdse-contentops` |

## Codex plugin mode

The repository also contains a valid Codex plugin manifest and marketplace entry. From a local checkout, add the repository as a local marketplace and install the plugin:

```sh
codex plugin marketplace add /absolute/path/to/hkdse-contentops
codex plugin add hkdse-contentops@hkdse-contentops
```

After installation or upgrade, start a new Codex task so Codex reloads the skill.
