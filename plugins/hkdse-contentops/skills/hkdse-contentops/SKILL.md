---
name: hkdse-contentops
description: Create four-format Hong Kong DSE content drafts. Use when the user asks for daily or topic-specific DSE content, 小红书文案, Instagram 香港文案, Reels/短视频口播, 直播话术, JUPAS 选科内容, 暑假班招生内容, 放榜季咨询内容, or a coordinated content package for a Hong Kong DSE education account.
---

# HKDSE ContentOps

Create one coherent Hong Kong DSE content pack in four formats: a Xiaohongshu post, an Instagram caption, a short-form video script, and a livestream script. Generate the drafts directly in Codex; do not call a separate model API.

## Determine Inputs

Use the topic, institution name, audience, campaign goal, and CTA channel supplied by the user.

- If no institution name is supplied, use neutral expressions such as “我们” or “导师团队”; never invent a brand.
- Use only a CTA channel the user actually provides. If none is provided, use a neutral save, comment, or follow CTA without inventing a phone number, link, WhatsApp, or DM service.
- If the user asks for a random or daily topic, choose a relevant topic such as DSE 放榜后的行动清单, JUPAS Band A 排位思路, different score-range planning, mainland-student DSE preparation, or a Form 5-to-Form 6 summer plan.

Do not ask follow-up questions when these defaults are sufficient.

## Match Language to Audience

Apply the audience language consistently across all four formats; do not decide language from the channel name alone.

- Hong Kong local students or parents: use Traditional Chinese with natural Hong Kong Cantonese phrasing.
- Mainland students or parents: use Simplified Chinese with natural Mandarin phrasing.
- If the user explicitly requests another language or register, follow it.
- If the audience is missing and the language choice would materially change the result, ask one concise audience question. Otherwise infer from context and state the assumption briefly.

## Choose Information Mode

Classify the topic before drafting.

### Evergreen mode

Use this mode for study methods, decision frameworks, communication advice, and other stable guidance. Do not browse by default. Avoid current dates, score lines, quotas, and policy claims that are unnecessary to the topic.

Do not add a current year to titles, body copy, or hashtags unless the user explicitly supplies that year and it is necessary to the request.

### Time-sensitive mode

Use this mode when the content involves JUPAS dates, application procedures, institution requirements, score lines, quotas, policies, or any claim that may change.

1. Use available web or search tools before drafting.
2. Prefer primary official sources in this order: HKEAA, JUPAS, Hong Kong Education Bureau, then the relevant institution's official website.
3. Cross-check each material claim against the source that owns it. Do not use tutoring-provider posts or social-media summaries as authority.
4. Add `资料截至：YYYY-MM-DD` near the top and add a `核验来源` list with source titles and URLs after the four content formats.
5. If browsing is unavailable or a claim cannot be confirmed, do not present it as fact. Insert `[待核验：具体项目]` and explain what official source must be checked.

## Generate Four Content Formats

Keep all four formats focused on the same topic, audience, information mode, and campaign goal.

### 小红书

- Provide one natural, information-rich title within 20 Chinese characters.
- Write short, concrete paragraphs with actionable advice.
- End with one compliant CTA and exactly five relevant hashtags.

### Instagram

- Provide a main title within 10 Chinese characters.
- Keep the caption within 120 Chinese characters, excluding the title.
- End with one compliant CTA.
- Keep the rhythm professional and direct without imitating a named institution.

### Reels 口播

- Write for a teacher speaking naturally on camera.
- Start with a strong three-second hook that names the audience or problem without creating anxiety.
- Write 30–60 seconds of spoken content with two to four concrete points.
- End with one easy-to-answer interaction question.

### 直播话术

- Include a 30-second opening, three interaction questions, comment guidance, optional resource wording, and a restrained course CTA when relevant.
- Make the script usable for a Tuesday, Thursday, or Saturday livestream without claiming a schedule the user did not provide.

## Apply Safety Rules

- Do not promise guaranteed passing, admission, score improvement, or limited places without evidence.
- Do not fabricate policies, score lines, statistics, student cases, prices, results, testimonials, or urgency.
- When the user asks for fabricated evidence or guaranteed outcomes, refuse that element briefly and provide a compliant alternative draft.
- Treat every result as a draft. Do not publish, send messages, or contact anyone unless explicitly requested.

## Final Check

Run this check before returning or saving the result. Revise the draft until every applicable item passes.

1. Count each title and body separately: Xiaohongshu title is at most 20 Chinese characters; Instagram title is at most 10; Instagram body is at most 120.
2. Confirm the Xiaohongshu section has exactly five hashtags.
3. Confirm all four formats use the same topic, audience, language choice, and factual basis.
4. Confirm each CTA uses only a channel or contact method supplied by the user; otherwise use a neutral engagement CTA.
5. Search for unverified numbers, dates, score lines, policy claims, fabricated cases, and guaranteed-result language.
6. In time-sensitive mode, confirm the cutoff date and official-source list are present, or mark every unresolved item as `[待核验：...]`.
7. In evergreen mode, remove unrequested year references and year-based hashtags.

## Return or Save

Return the complete Markdown in the response by default. Save a file only when the user explicitly asks to save or export it.

Use this structure:

```markdown
# 主题

> 资料截至：YYYY-MM-DD（仅时效内容）

## 小红书
...

---

## Instagram
...

---

## Reels 口播
...

---

## 直播话术
...

## 核验来源（仅时效内容）
- 来源标题：https://official.example/...
```

When the user requests saving:

1. Use the requested destination, or default to `output/YYYY-MM-DD/` in the current workspace.
2. Build a safe filename from the topic. Remove `/`, `\`, control characters, and every `..` sequence; collapse repeated whitespace; never allow the topic to escape the destination directory.
3. Use UTF-8 Markdown. If the target exists, append `-2`, `-3`, and so on. Never overwrite an existing draft automatically.
4. Report the selected topic and provide a clickable absolute link to the new file.
