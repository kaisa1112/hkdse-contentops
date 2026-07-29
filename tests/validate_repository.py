#!/usr/bin/env python3
import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PLUGIN = ROOT / "plugins" / "hkdse-contentops"
SKILL_DIR = PLUGIN / "skills" / "hkdse-contentops"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def load_json(path: Path) -> dict:
    with path.open("r", encoding="utf-8") as file:
        return json.load(file)


def main() -> None:
    required_files = [
        ROOT / ".agents" / "plugins" / "marketplace.json",
        ROOT / ".github" / "workflows" / "validate.yml",
        ROOT / "CONTRIBUTING.md",
        ROOT / "LICENSE",
        ROOT / "README.md",
        PLUGIN / ".codex-plugin" / "plugin.json",
        SKILL_DIR / "SKILL.md",
        SKILL_DIR / "agents" / "openai.yaml",
        ROOT / "tests" / "golden_cases.json",
    ]
    for path in required_files:
        require(path.is_file(), f"Missing required file: {path.relative_to(ROOT)}")

    manifest = load_json(PLUGIN / ".codex-plugin" / "plugin.json")
    marketplace = load_json(ROOT / ".agents" / "plugins" / "marketplace.json")
    golden = load_json(ROOT / "tests" / "golden_cases.json")

    require(manifest["name"] == "hkdse-contentops", "Plugin name mismatch")
    require(manifest["version"] == "0.2.0", "Expected plugin version 0.2.0")
    require(manifest["skills"] == "./skills/", "Plugin skills path mismatch")
    require(marketplace["name"] == "hkdse-contentops", "Marketplace name mismatch")
    require(
        marketplace["plugins"][0]["source"]["path"] == "./plugins/hkdse-contentops",
        "Marketplace source path mismatch",
    )

    skill = (SKILL_DIR / "SKILL.md").read_text(encoding="utf-8")
    frontmatter = re.match(r"^---\n(.*?)\n---\n", skill, re.DOTALL)
    require(frontmatter is not None, "SKILL.md frontmatter is invalid")
    require("name: hkdse-contentops" in frontmatter.group(1), "Skill name mismatch")

    required_skill_terms = [
        "## Match Language to Audience",
        "## Choose Information Mode",
        "### Evergreen mode",
        "Do not add a current year to titles, body copy, or hashtags",
        "### Time-sensitive mode",
        "HKEAA",
        "JUPAS",
        "Hong Kong Education Bureau",
        "资料截至：YYYY-MM-DD",
        "[待核验：具体项目]",
        "## Final Check",
        "remove unrequested year references and year-based hashtags",
        "exactly five hashtags",
        "Save a file only when the user explicitly asks",
        "Never overwrite an existing draft automatically",
    ]
    for term in required_skill_terms:
        require(term in skill, f"Missing skill requirement: {term}")

    public_text = "\n".join(
        path.read_text(encoding="utf-8")
        for path in [ROOT / "README.md", SKILL_DIR / "SKILL.md"]
    ).lower()
    for forbidden in ("four-platform", "四个平台", "platform-ready", "calvin"):
        require(forbidden not in public_text, f"Forbidden wording remains: {forbidden}")

    cases = golden.get("cases")
    require(isinstance(cases, list), "golden_cases.json cases must be a list")
    require(len(cases) == 8, "Expected exactly eight golden cases")
    require(sum(case.get("kind") == "positive" for case in cases) == 5, "Expected five positive cases")
    require(sum(case.get("kind") == "negative" for case in cases) == 3, "Expected three negative cases")
    ids = [case.get("id") for case in cases]
    require(len(ids) == len(set(ids)), "Golden case IDs must be unique")
    for case in cases:
        require(case.get("prompt"), f"Missing prompt in {case.get('id')}")
        checks = case.get("expected_checks")
        require(isinstance(checks, list) and len(checks) >= 3, f"Insufficient checks in {case.get('id')}")

    print("Repository structure: OK")
    print("Plugin and marketplace metadata: OK")
    print("Skill workflow requirements: OK")
    print("Golden cases: 5 positive + 3 negative")


if __name__ == "__main__":
    main()
