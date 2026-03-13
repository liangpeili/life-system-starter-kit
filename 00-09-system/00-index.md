# Johnny.Decimal 索引

这个 starter kit 采用的是一套务实版的 Johnny.Decimal 结构。

## 区域（Areas）

- `00-09-system/` —— 索引和系统约定
- `10-19-planning/` —— 人生规划与年度目标
- `20-29-journal/` —— 每日日记与每周复盘
- `30-39-knowledge/` —— 参考资料、决策、研究
- `40-49-relationships/` —— 人物笔记
- `50-59-capture/` —— 收件箱与快速捕捉
- `90-99-system/` —— 模板、脚本预留、agent skills 归档说明

## 类别（Categories）

- `10-19-planning/11-life-plan/plan.md`
- `10-19-planning/12-annual-goals/YYYY.md`
- `20-29-journal/21-daily/YYYY/MM/YYYY-MM-DD.md`
- `20-29-journal/22-weekly/YYYY/week-WW.md`
- `30-39-knowledge/31-reference/`
- `30-39-knowledge/32-decisions/`
- `30-39-knowledge/33-research/`
- `40-49-relationships/41-people/`
- `50-59-capture/51-inbox/inbox.md`
- `90-99-system/91-templates/`
- `90-99-system/92-scripts/`
- `90-99-system/93-skills/`

## OpenClaw 运行时补充

为了让这个仓库本身可以直接作为 OpenClaw workspace，根目录保留 `skills/` 作为运行时 skill 入口。

- `skills/morning/` —— 晨间启动
- `skills/midday/` —— 午间检查
- `skills/evening/` —— 晚间总结
- `90-99-system/93-skills/morning/` —— morning 的 Johnny.Decimal 归档入口
- `90-99-system/93-skills/midday/` —— midday 的 Johnny.Decimal 归档入口
- `90-99-system/93-skills/evening/` —— evening 的 Johnny.Decimal 归档入口

`90-99-system/92-scripts/` 现在只是可选的本地自动化预留目录，不再承载默认入口。

## 使用规则

1. 顶层 area 要小而稳定。
2. 只有当现有类别已经明显拥挤时，才新增类别。
3. 优先使用稳定的编号目录，不要把内容越嵌越深。
4. 一条笔记应该放在你“下次最可能去找它”的地方。
5. 如果某条笔记已经重要到会被反复引用，就给它一个 ID，并写进文件元信息里。

## 建议使用的 ID 前缀

- `11.xx` 人生规划相关笔记
- `12.xx` 年度规划相关笔记
- `21.xx` 每日日记的辅助笔记
- `22.xx` 每周复盘笔记
- `31.xx` 参考资料
- `32.xx` 决策记录
- `33.xx` 研究笔记
- `41.xx` 人物笔记
- `51.xx` inbox / capture 的辅助笔记
