# Contributing

Contributions that improve Hong Kong DSE topic coverage, audience tone, factual verification, safety wording, or output consistency are welcome.

## Validate locally

Run the repository validator before opening a pull request.

macOS / Linux:

```bash
python3 tests/validate_repository.py
```

Windows PowerShell:

```powershell
py -3 tests\validate_repository.py
```

If the Codex creator skills are installed, also run the official validators:

```bash
python3 ~/.codex/skills/.system/plugin-creator/scripts/validate_plugin.py plugins/hkdse-contentops
python3 ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py plugins/hkdse-contentops/skills/hkdse-contentops
```

On Windows PowerShell, use `py -3` and the equivalent paths under `$HOME\.codex`.

Manually run the twelve prompts in `tests/golden_cases.json` in fresh Codex or Claude sessions and compare the result with every `expected_checks` item. Do not publish generated drafts during evaluation.

## Pull requests

1. Fork the repository and create a focused branch.
2. Keep the skill brand-neutral and free of credentials or machine-specific paths.
3. Preserve platform-native routing: Instagram uses Traditional Chinese and local Cantonese; Xiaohongshu uses Simplified Chinese and Mandarin; unspecified daily requests return both.
4. Keep the Daily Pack research-first: official facts, Hong Kong context, platform demand signals, and parent/student concerns.
5. Keep time-sensitive claims tied to official sources and a cutoff date.
6. Avoid unverifiable education claims, external diversion, fabricated evidence, and guaranteed-result language.
7. Add or update a golden case when behavior changes.
8. Keep skill resources host-neutral and free of machine-specific paths, drive letters, shell assumptions, or required proprietary connectors.

Keep changes small and explain the user-facing improvement in the pull request description.
