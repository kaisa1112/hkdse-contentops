# HKDSE ContentOps

An open-source Codex plugin and skill for creating platform-ready social-media content for Hong Kong DSE education accounts.

一个面向香港 DSE 教育账号的新媒体内容运营 Codex Plugin / Skill。一次生成小红书、Instagram、Reels 口播和直播话术。

## Features / 功能

- One topic, four coordinated platform drafts / 一个主题生成四个平台内容
- Simplified Chinese Xiaohongshu copy / 简体中文小红书文案
- Traditional Chinese with Hong Kong Cantonese phrasing for Instagram / 繁体中文及香港粤语风格 IG 文案
- 30–60 second teacher-led Reels script / 30–60 秒老师真人口播
- Livestream opening, interactions, private-message CTA, and summer-course CTA / 直播开场、互动、私信及暑假班 CTA
- Brand-neutral by default; uses a supplied institution name when provided / 默认不绑定品牌，可按需指定机构名称
- No API key, server, Python runtime, or external dependency / 无需 API Key、服务器、Python 或外部依赖
- Avoids guaranteed-result claims and fabricated education data / 避免保过、保录取及虚构教育数据

## Install as a Codex Plugin / 作为 Plugin 安装

Add this GitHub repository as a marketplace source:

```bash
codex plugin marketplace add z2429875275-cell/hkdse-contentops
```

Restart Codex, open the Plugins Directory, select the **HKDSE ContentOps** source, and install the plugin.

重启 Codex，在插件目录中选择 **HKDSE ContentOps** 来源，然后安装插件。

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

指定主题：

```text
使用 $hkdse-contentops 围绕“JUPAS Band A 怎样排更合理”生成内容。
```

指定机构：

```text
使用 $hkdse-contentops 为「机构名称」生成“中五升中六暑假规划”内容。
```

When file access is available, the skill saves Markdown to `output/YYYY-MM-DD/<topic>.md` in the current workspace.

## Project Structure / 项目结构

```text
hkdse-contentops/
├── .agents/plugins/marketplace.json
├── plugins/hkdse-contentops/
│   ├── .codex-plugin/plugin.json
│   └── skills/hkdse-contentops/
│       ├── SKILL.md
│       └── agents/openai.yaml
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## Privacy / 隐私

This project contains instructions only. It does not collect data, require credentials, or send content to a separate API. Content generation is handled by the user's Codex environment.

本项目只包含工作流指令，不收集数据、不需要密钥，也不会调用独立的外部 API。内容由使用者自己的 Codex 环境生成。

## License

[MIT](LICENSE)
