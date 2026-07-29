# HKDSE ContentOps

An open-source Codex plugin and skill for creating four coordinated content formats for Hong Kong DSE education accounts.

一个面向香港 DSE 教育账号的新媒体内容运营 Codex Plugin / Skill，一次生成四种内容格式：小红书图文、Instagram 文案、短视频口播和直播话术。

## Features / 功能

- One topic, four coordinated content formats / 一个主题生成四种内容格式
- Audience-aware language: Hong Kong Traditional Chinese and Cantonese, or Mainland Simplified Chinese and Mandarin / 语言跟随受众，而不是跟随平台名称
- Evergreen mode for stable guidance without browsing / 常青模式用于稳定建议，默认无需联网
- Time-sensitive mode with official-source verification and a data cutoff date / 时效模式优先核验官方来源并注明资料截至日期
- Hard final checks for length, hashtags, consistency, CTA channels, and factual claims / 对字数、标签、主题一致性、CTA 渠道和事实进行硬性自检
- Brand-neutral by default; uses a supplied institution name only when provided / 默认不绑定品牌，仅使用用户提供的机构名称
- Returns Markdown by default; saves only on request and never overwrites an existing draft / 默认在对话中返回，按要求保存且不覆盖旧稿
- No API key, server, Python runtime, or external dependency for content generation / 内容生成无需 API Key、服务器、Python 或外部依赖

## Information modes / 信息模式

**Evergreen / 常青内容** covers stable study methods, planning frameworks, and communication advice. It avoids unnecessary current facts and does not browse by default.

**Time-sensitive / 时效内容** covers JUPAS dates, institution requirements, score lines, application procedures, and policies. The skill uses available search tools, prioritizes HKEAA, JUPAS, EDB, and institution websites, then adds a cutoff date and official-source list. Unresolved facts remain visibly marked for verification.

## Audience language / 受众语言

- Hong Kong local audience: Traditional Chinese with natural Cantonese phrasing / 香港本地受众：繁体中文＋自然粤语口吻
- Mainland audience: Simplified Chinese with natural Mandarin phrasing / 内地学生及家长：简体中文＋普通话口吻
- When audience ambiguity materially affects the result, the skill asks one concise question / 只有受众不明确且明显影响结果时才询问一次

## Install as a Codex Plugin / 作为 Plugin 安装

```bash
codex plugin marketplace add z2429875275-cell/hkdse-contentops
codex plugin add hkdse-contentops@hkdse-contentops
```

Start a new Codex task after installation.

## Install only the Skill / 仅安装 Skill

Ask Codex:

```text
Use $skill-installer to install:
https://github.com/z2429875275-cell/hkdse-contentops/tree/main/plugins/hkdse-contentops/skills/hkdse-contentops
```

If the skill does not appear immediately, restart Codex.

## Usage / 使用方法

Random daily topic / 随机每日选题：

```text
Use $hkdse-contentops to generate today's Hong Kong DSE content pack.
```

指定受众和主题：

```text
使用 $hkdse-contentops 面向香港本地中六学生，围绕“JUPAS Band A 排位”生成四类内容。
```

时效内容：

```text
使用 $hkdse-contentops 核验最新官方资料后，生成今年 JUPAS 改选安排的四类内容。
```

保存文件必须明确提出：

```text
使用 $hkdse-contentops 生成内容，并保存到 output 目录，不要覆盖旧稿。
```

## Validation / 验证

Run the reproducible repository checks:

```bash
python3 tests/validate_repository.py
```

The golden-case suite contains five positive activation cases and three negative safety cases in [`tests/golden_cases.json`](tests/golden_cases.json). GitHub Actions runs the validator on every push and pull request.

## Project Structure / 项目结构

```text
hkdse-contentops/
├── .agents/plugins/marketplace.json
├── .github/workflows/validate.yml
├── plugins/hkdse-contentops/
│   ├── .codex-plugin/plugin.json
│   └── skills/hkdse-contentops/
│       ├── SKILL.md
│       └── agents/openai.yaml
├── tests/
│   ├── golden_cases.json
│   └── validate_repository.py
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## Privacy / 隐私

This project contains workflow instructions only. It does not collect data, require credentials, or send content to a separate API. Time-sensitive research uses tools available in the user's own Codex environment.

本项目只包含工作流指令，不收集数据、不需要密钥，也不会调用独立模型 API。时效资料核验使用用户自身 Codex 环境中可用的工具。

## License

[MIT](LICENSE)
