---
name: hkdse-contentops
description: Create platform-ready Hong Kong DSE content operations packs. Use when the user asks for daily or topic-specific DSE content, 小红书文案, Instagram 香港文案, Reels/短视频口播, 直播话术, JUPAS 选科内容, 暑假班招生内容, 放榜季咨询内容, or a reusable multi-platform content package for a Hong Kong DSE education account.
---

# HKDSE ContentOps

Create one coherent content pack for a Hong Kong DSE education account. Generate the content directly in Codex; do not call a separate model API.

## Determine Inputs

Use the topic, institution name, audience, and campaign goal supplied by the user. If no institution name is supplied, use neutral expressions such as “我们” or “导师团队”; never invent a brand.

If the user asks for a random or daily topic, choose one relevant topic such as:

- DSE 放榜后的行动清单
- JUPAS Band A 排位思路
- 不同分数区间的选科方向
- 内地学生报考香港 DSE 的准备重点
- 中五升中六暑假复习规划

Do not ask follow-up questions when these defaults are sufficient.

## Generate the Pack

Write all four sections around the same topic.

### 小红书

- Use polished Simplified Chinese for students and parents in mainland China.
- Provide one natural information-rich title within 20 Chinese characters.
- Write short, concrete paragraphs with actionable advice.
- End with one light private-message CTA and exactly five relevant hashtags.

### Instagram

- Use Traditional Chinese with natural Hong Kong Cantonese phrasing.
- Provide a main title within 10 Chinese characters.
- Keep the IG caption within 120 Chinese characters.
- End with one DM or WhatsApp CTA.
- Keep the rhythm professional and direct without imitating a named institution.

### Reels 口播

- Write in Simplified Chinese for a teacher speaking naturally on camera.
- Start with a strong three-second hook that names the audience or problem without creating anxiety.
- Write 30–60 seconds of spoken content with two to four concrete points.
- End with one easy-to-answer interaction question.

### 直播话术

- Write in Simplified Chinese with only widely understood Hong Kong education terms.
- Include a 30-second opening, three interaction questions, comment guidance, private-message resource wording, and a restrained summer-course CTA.
- Make it suitable for Tuesday, Thursday, or Saturday livestreams.

## Apply Safety Rules

- Do not promise guaranteed passing, admission, score improvement, or limited places without evidence.
- Do not fabricate policies, score lines, statistics, student cases, prices, or results.
- For changing policies and dates, give stable general guidance and tell readers to check the latest official announcement.
- Treat the result as a draft. Do not publish, send messages, or contact anyone unless explicitly requested.

## Format and Save

Use this Markdown structure:

```markdown
# 主题

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
```

When filesystem access is available, save the result under the current workspace as `output/YYYY-MM-DD/<topic>.md` using UTF-8. Sanitize characters that are invalid in filenames. Otherwise return the complete Markdown in the response.

After saving, report the selected topic and provide a clickable absolute link to the output file. Do not paste the full content again unless the user asks.
