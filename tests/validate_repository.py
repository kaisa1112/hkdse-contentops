#!/usr/bin/env python3
import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PLUGIN = ROOT / "plugins" / "hkdse-contentops"
SKILL_DIR = PLUGIN / "skills" / "hkdse-contentops"
REFERENCE_NAMES = [
    "research-topic-selection.md",
    "instagram-output.md",
    "instagram-growth.md",
    "xiaohongshu-output.md",
    "livestream-growth.md",
    "operations-growth.md",
]


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
        ROOT / "INSTALL.md",
        ROOT / "scripts" / "install-skill.sh",
        ROOT / "scripts" / "install-skill.ps1",
        PLUGIN / ".codex-plugin" / "plugin.json",
        PLUGIN / "assets" / "dse-icon.png",
        SKILL_DIR / "SKILL.md",
        SKILL_DIR / "agents" / "openai.yaml",
        ROOT / "tests" / "golden_cases.json",
    ] + [SKILL_DIR / "references" / name for name in REFERENCE_NAMES]
    for path in required_files:
        require(path.is_file(), f"Missing required file: {path.relative_to(ROOT)}")

    manifest = load_json(PLUGIN / ".codex-plugin" / "plugin.json")
    marketplace = load_json(ROOT / ".agents" / "plugins" / "marketplace.json")
    golden = load_json(ROOT / "tests" / "golden_cases.json")

    require(manifest["name"] == "hkdse-contentops", "Plugin name mismatch")
    require(manifest["author"]["name"] == "kaisa1112", "Plugin author mismatch")
    require(manifest["interface"]["developerName"] == "kaisa1112", "Plugin developer mismatch")
    require(
        manifest["repository"] == "https://github.com/kaisa1112/hkdse-contentops",
        "Plugin repository URL mismatch",
    )
    require(
        manifest["interface"]["displayName"] == "HKDSE ContentOps",
        "Plugin display name mismatch",
    )
    require(
        "香港中学文凭考试（HKDSE）" in manifest["description"],
        "Plugin description must disambiguate HKDSE",
    )
    require(
        "香港中学文凭考试（HKDSE）" in manifest["interface"]["shortDescription"],
        "Plugin short description must disambiguate HKDSE",
    )
    require(
        "香港中学文凭考试（HKDSE）" in manifest["interface"]["longDescription"],
        "Plugin long description must disambiguate HKDSE",
    )
    require(
        manifest["version"].split("+", 1)[0] == "0.4.0",
        "Expected plugin base version 0.4.0",
    )
    require(manifest["skills"] == "./skills/", "Plugin skills path mismatch")
    require(manifest["interface"]["brandColor"] == "#4F6FF0", "Plugin brand color mismatch")
    require(
        manifest["interface"]["composerIcon"] == "./assets/dse-icon.png",
        "Plugin composer icon mismatch",
    )
    require(
        manifest["interface"]["logo"] == "./assets/dse-icon.png",
        "Plugin logo mismatch",
    )
    require(
        len(manifest["interface"]["defaultPrompt"]) <= 3,
        "Plugin must expose no more than three default prompts",
    )
    require(
        all(len(prompt) <= 128 for prompt in manifest["interface"]["defaultPrompt"]),
        "Plugin default prompts must be at most 128 characters",
    )
    require(marketplace["name"] == "hkdse-contentops", "Marketplace name mismatch")
    require(
        marketplace["plugins"][0]["source"]["path"] == "./plugins/hkdse-contentops",
        "Marketplace source path mismatch",
    )

    skill = (SKILL_DIR / "SKILL.md").read_text(encoding="utf-8")
    frontmatter = re.match(r"^---\n(.*?)\n---\n", skill, re.DOTALL)
    require(frontmatter is not None, "SKILL.md frontmatter is invalid")
    require("name: hkdse-contentops" in frontmatter.group(1), "Skill name mismatch")

    openai_yaml = (SKILL_DIR / "agents" / "openai.yaml").read_text(encoding="utf-8")
    require(
        'display_name: "HKDSE ContentOps"' in openai_yaml,
        "Skill display name mismatch",
    )
    require(
        "香港中学文凭考试（HKDSE）" in openai_yaml,
        "Skill description must disambiguate HKDSE",
    )

    full_name = "Hong Kong Diploma of Secondary Education Examination ContentOps"
    short_name = "HKDSE ContentOps"
    chinese_name = "香港中学文凭考试"
    readme = (ROOT / "README.md").read_text(encoding="utf-8")
    require(full_name in readme, "README full name mismatch")
    require(short_name in readme, "README short name mismatch")
    require(full_name in skill, "Skill full name mismatch")
    require(short_name in skill, "Skill short name mismatch")
    require(chinese_name in readme, "README Chinese name mismatch")
    require(chinese_name in skill, "Skill Chinese name mismatch")

    required_skill_terms = [
        "Daily content",
        "No platform specified for “today/daily HKDSE content”",
        "Traditional Chinese and natural Hong Kong written Cantonese",
        "Simplified Chinese and natural Mandarin",
        "Official facts",
        "Platform demand",
        "资料截至：YYYY-MM-DD",
        "[待核验：具体项目]",
        "exactly five hashtags",
        "Account diagnosis",
        "Instagram Daily Pack",
        "Xiaohongshu Daily Pack",
        "Remain portable in Codex",
    ]
    for term in required_skill_terms:
        require(term in skill, f"Missing skill requirement: {term}")

    for name in REFERENCE_NAMES:
        require(
            f"references/{name}" in skill,
            f"SKILL.md does not route to reference: {name}",
        )

    skill_files = [SKILL_DIR / "SKILL.md"] + [
        SKILL_DIR / "references" / name for name in REFERENCE_NAMES
    ]
    for path in skill_files:
        content = path.read_text(encoding="utf-8")
        require("/Users/" not in content, f"macOS machine path found in {path.name}")
        require("C:\\Users\\" not in content, f"Windows machine path found in {path.name}")

    readme = (ROOT / "README.md").read_text(encoding="utf-8")
    for term in ("Codex", "Windows", "macOS", "Linux"):
        require(term in readme, f"README missing portability term: {term}")

    public_text = "\n".join(
        path.read_text(encoding="utf-8")
        for path in [ROOT / "README.md", SKILL_DIR / "SKILL.md"]
    ).lower()
    for forbidden in ("保证录取", "保证提分", "calvin"):
        require(forbidden not in public_text, f"Forbidden wording remains: {forbidden}")

    cases = golden.get("cases")
    require(isinstance(cases, list), "golden_cases.json cases must be a list")
    require(len(cases) == 12, "Expected exactly twelve golden cases")
    require(sum(case.get("kind") == "positive" for case in cases) == 8, "Expected eight positive cases")
    require(sum(case.get("kind") == "negative" for case in cases) == 4, "Expected four negative cases")
    ids = [case.get("id") for case in cases]
    require(len(ids) == len(set(ids)), "Golden case IDs must be unique")
    for case in cases:
        require(case.get("prompt"), f"Missing prompt in {case.get('id')}")
        checks = case.get("expected_checks")
        require(isinstance(checks, list) and len(checks) >= 3, f"Insufficient checks in {case.get('id')}")

    print("Repository structure: OK")
    print("Plugin and marketplace metadata: OK")
    print("Skill workflow and reference routing: OK")
    print("Codex and OS portability: OK")
    print("Golden cases: 8 positive + 4 negative")


if __name__ == "__main__":
    main()
