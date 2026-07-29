# Contributing

Contributions that improve Hong Kong DSE topic coverage, audience tone, factual verification, safety wording, or output consistency are welcome.

## Validate locally

Run the repository validator before opening a pull request:

```bash
python3 tests/validate_repository.py
```

If the Codex creator skills are installed, also run the official validators:

```bash
python3 ~/.codex/skills/.system/plugin-creator/scripts/validate_plugin.py plugins/hkdse-contentops
python3 ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py plugins/hkdse-contentops/skills/hkdse-contentops
```

Manually run the eight prompts in `tests/golden_cases.json` in fresh Codex tasks and compare the result with every `expected_checks` item. Do not publish generated drafts during evaluation.

## Pull requests

1. Fork the repository and create a focused branch.
2. Keep the skill brand-neutral and free of credentials or machine-specific paths.
3. Preserve the four required content formats.
4. Keep time-sensitive claims tied to official sources and a cutoff date.
5. Avoid unverifiable education claims and guaranteed-result language.
6. Add or update a golden case when behavior changes.

Keep changes small and explain the user-facing improvement in the pull request description.
