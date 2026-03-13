# Morning Skill 参考

以下路径默认都相对当前 OpenClaw workspace 根目录；如果这个仓库本身就是 workspace，就直接使用这些路径。

## 文件位置

```text
00-09-system/00-index.md
10-19-planning/11-life-plan/plan.md
10-19-planning/12-annual-goals/YYYY.md
20-29-journal/21-daily/YYYY/MM/YYYY-MM-DD.md
20-29-journal/22-weekly/YYYY/week-WW.md
30-39-knowledge/31-reference/values.md
30-39-knowledge/32-decisions/
40-49-relationships/41-people/
50-59-capture/51-inbox/inbox.md
90-99-system/91-templates/
```

## 在 OpenClaw 中的运行位置

- `skills/morning/`、`skills/midday/`、`skills/evening/` 是 OpenClaw 在当前 workspace 根目录下发现的运行时入口。
- 这里的 `skills/morning/` 也是 `morning` skill 的唯一维护入口。

## 推荐触发节奏

- 08:30：`morning`
- 12:30：`midday`
- 21:00：`evening`

## 任务管理

- 快速捕捉：`50-59-capture/51-inbox/inbox.md`
- 每日待办：放在当天日记的早晨部分
- 项目任务：放在对应的项目仓库或规划笔记里

## 可选：日历集成（macOS）

安装 `icalBuddy`，把日历事件拉进每日笔记：

```bash
brew install ical-buddy
```
