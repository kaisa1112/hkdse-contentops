# Hong Kong Diploma of Secondary Education Examination ContentOps

Short name / 简称：**HKDSE ContentOps**

An open-source, cross-host skill and Codex plugin for Hong Kong DSE Instagram and Xiaohongshu acquisition.

一个面向香港 DSE 赛道新媒体运营人员的双平台 Skill。支持 Codex 与 Claude，以及 Windows、macOS 和 Linux。它先调研最新官方信息、香港本地语境、平台需求和家长/学生问题，再生成平台原生内容、获客闭环和运营复盘。

## 功能

- “帮我生成今天的香港 DSE 内容”：研究一次，分别生成 IG 与小红书原生 Daily Pack
- 官方信息核验：优先 HKEAA、JUPAS、香港教育局和相关院校官网
- 平台需求研究：分析 IG、小红书与香港本地公开讨论，但不把社交内容当政策来源
- 家长与学生问题挖掘：识别选科、备考、流程、情绪和信任障碍
- 香港本地 IG：繁体字、书面粤语、4:5轮播、9:16 Reels、Stories、标题、正文、设计和Tag
- 普通话小红书图文：标题、正文、5个标签、评论引导和6–8页逐页设计
- 普通话短视频：3秒钩子、30–60秒逐字稿、镜头字幕、正文和5个标签
- 直播获客闭环：规则、人货场、预热、60–90分钟流程、逐字话术、评论、站内转化和复盘
- 周/月运营：定位、内容矩阵、排期、漏斗、复用和实验
- 账号诊断：根据笔记或直播数据定位流量、留存、互动、关注或转化问题
- 合规保护：不编政策、分数、案例、名额或成绩，不承诺结果，不设计站外导流规避方案

明确指定 IG 时，只生成香港本地繁体粤语内容；明确指定小红书时，只生成简体普通话内容；每日请求未指定平台时，生成两个平台各自原生版本，不做逐字翻译。

## 使用示例

每日完整内容：

```text
使用 $hkdse-contentops 帮我生成今天的香港 DSE 内容。
```

只生成香港本地 IG：

```text
使用 $hkdse-contentops 幫我生成今日香港DSE IG完整內容。
```

指定选题：

```text
使用 $hkdse-contentops 围绕“DSE错题复盘”生成小红书图文和视频。
```

政策快反：

```text
使用 $hkdse-contentops 根据最新官方消息，做今天的JUPAS政策快反内容。
```

完整直播：

```text
使用 $hkdse-contentops 做一场DSE选科直播闭环，包括规则、人货场、逐字话术、评论互动、站内转化和复盘。
```

月度运营：

```text
使用 $hkdse-contentops 制定一个月的香港DSE小红书获客运营计划。
```

账号诊断：

```text
使用 $hkdse-contentops 分析我过去十篇DSE笔记的数据，给下一轮单变量优化方案。
```

## IG Daily Pack

1. 今日研判：官方动态、香港语境、IG需求和学生/家长问题
2. IG图文：4:5、7–9页繁体粤语文案与逐页设计
3. IG Reels：9:16、0–2秒钩子、20–40秒粤语逐字稿、镜头字幕
4. IG Stories：投票、测验、问题箱与Feed承接
5. 标题、Caption、CTA、5–8个相关Tag
6. 发布顺序、Highlights/DM承接、A/B变量和下一条FAQ
7. 核验来源与研究限制

## 小红书 Daily Pack

1. 今日研判：资料截止时间、官方动态、站内需求、家长/学生问题、候选选题和选择理由
2. 小红书图文：封面、标题、正文、互动和5个标签
3. 图文设计：3:4视觉方向及6–8页逐页文案与布局
4. 短视频：封面、标题、3秒钩子、逐字稿、镜头字幕、正文、互动和5个标签
5. 直播承接：直播题目、30秒开场、互动问题和合规下一步
6. 发布与获客：发布顺序、评论处理、A/B变量和下一条衍生内容
7. 核验来源：官方事实来源与明确标注的平台趋势样本

如果当天没有重大官方更新，技能会明确说明，并根据当前DSE阶段、近期平台需求和家长问题选择常青内容，不会伪造“今日新闻”。

## 信息原则

**时效内容**包括日期、政策、流程、院校要求、分数、配额、考试安排和平台规则。必须联网核验、注明资料截至日期并给出官方来源。

**常青内容**包括学习方法、诊断框架、复习计划和家长沟通。平台调研可以帮助选择角度，但不会强行添加年份或虚构政策变化。

## 跨平台安装

完整说明见 [INSTALL.md](INSTALL.md)。技能核心只有 UTF-8 Markdown/YAML，不依赖特定操作系统、Shell、绝对路径或单一研究工具。

macOS / Linux：

```sh
./scripts/install-skill.sh --target both
```

Windows PowerShell：

```powershell
.\scripts\install-skill.ps1 -Target both
```

安装器可选择 `codex`、`claude` 或 `both`。已有版本不会被静默覆盖；显式使用 `--force`／`-Force` 时会先创建时间戳备份。

### Codex Plugin

作为 Codex Plugin 安装：

```bash
codex plugin marketplace add kaisa1112/hkdse-contentops
codex plugin add hkdse-contentops@hkdse-contentops
```

### 仅安装 Skill

```text
Use $skill-installer to install:
https://github.com/kaisa1112/hkdse-contentops/tree/main/plugins/hkdse-contentops/skills/hkdse-contentops
```

安装或升级后开启新的 Codex 任务或 Claude 会话。

## 验证

macOS / Linux：

```bash
python3 tests/validate_repository.py
python3 ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py plugins/hkdse-contentops/skills/hkdse-contentops
```

Windows PowerShell：

```powershell
py -3 tests\validate_repository.py
py -3 "$HOME\.codex\skills\.system\skill-creator\scripts\quick_validate.py" plugins\hkdse-contentops\skills\hkdse-contentops
```

`tests/golden_cases.json` 包含双平台每日内容、IG完整内容、IG月度运营、小红书内容、政策快反、直播、账号诊断和安全边界测试。

## 项目结构

```text
hkdse-contentops/
├── INSTALL.md
├── scripts/
│   ├── install-skill.sh
│   └── install-skill.ps1
├── .agents/plugins/marketplace.json
├── plugins/hkdse-contentops/
│   ├── assets/dse-icon.png
│   ├── .codex-plugin/plugin.json
│   └── skills/hkdse-contentops/
│       ├── SKILL.md
│       ├── agents/openai.yaml
│       └── references/
│           ├── research-topic-selection.md
│           ├── instagram-output.md
│           ├── instagram-growth.md
│           ├── xiaohongshu-output.md
│           ├── livestream-growth.md
│           └── operations-growth.md
└── tests/
    ├── golden_cases.json
    └── validate_repository.py
```

## 隐私与安全

本项目只包含工作流和写作说明，不收集凭据。调研使用用户自身 Codex 环境中的可用工具。不会自动发布内容，不会要求未成年人公开姓名、学校、成绩或联系方式。

## License

[MIT](LICENSE)
