# 个人生活操作系统

一个基于 Claude Code 的个人生活操作系统。灵感来自 Carmack 的 `.plan` 文件、富兰克林式自我修炼，以及 Johnny.Decimal 对“东西要放得快、找得快”的强调。

## 这是什么

这是一套纯文本的生活管理系统：用来做人生规划、每日记录、重要决策和任务捕捉，并让 Claude Code 成为你的思考伙伴。没有 App，没有订阅，只有 Markdown 文件、终端，以及一个会适时提出质疑的 AI。

## 这里怎么体现 Johnny.Decimal

这个 starter kit 现在采用了一套务实版的 Johnny.Decimal 结构：

- **Areas（区域）** 让顶层结构保持小而稳定（例如 `10-19-planning`、`20-29-journal`）
- **Categories（类别）** 让不同类型的信息有明确归宿（例如 `11-life-plan`、`32-decisions`、`41-people`）
- `00-09-system/00-index.md` 作为整套系统的索引入口，也就是你的 JDex

重点不是为了“编号而编号”，而是让笔记更容易归档、更容易找回，也更不容易被层层嵌套埋掉。

## 你会得到什么

- **人生规划** —— 10 年愿景、人生阶段、你真正想优化的东西
- **年度目标** —— 今年的重点下注、不做清单、你正在成为怎样的人
- **每日日记** —— 富兰克林晨间问题 + Carmack 风格时间戳日志 + 晚间反思
- **决策记录** —— 用结构化文档记录重要决策，方便以后回看当时怎么想的
- **收件箱** —— 快速捕捉任务、想法、待处理事项
- **价值观与习惯** —— 把原则和日常节奏写下来，让 Claude 能据此提醒你
- **人物笔记** —— 记录你要见面、合作或研究的人
- **研究笔记** —— 针对公司、技术、市场、概念等主题做深入整理

## 配置方法

### 1. 安装 Claude Code

```bash
npm install -g @anthropic-ai/claude-code
```

### 2. 复制 `CLAUDE.md`

把当前目录里的 `CLAUDE.md` 复制到 `~/.claude/CLAUDE.md`。这是全局说明文件，用来告诉 Claude 应该如何与你协作。

```bash
cp CLAUDE.md ~/.claude/CLAUDE.md
```

复制后请**自己改一遍**：把占位符替换成你的名字、项目、路径和偏好。重点就是让它真正变成“你的系统”。

### 3. 安装 morning skill

`/morning` skill 负责驱动你的晨间流程。把它复制到 Claude Code 的 skills 目录：

```bash
mkdir -p ~/.claude/skills
cp -r 90-99-system/93-skills/morning ~/.claude/skills/morning
```

然后**修改 skill 文件**：把 `SKILL.md` 和 `reference.md` 里的 `YOURNAME` 换成你的名字。

### 4. 安装日记脚本

`jrn` 命令会用模板创建今天的日记；如果中间断了几天，它也会自动补齐缺失日期，并带上未完成事项、进行中的决策和日历事件，最后用你的编辑器打开当天文件。

```bash
mkdir -p ~/.scripts
cp 90-99-system/92-scripts/journal.sh ~/.scripts/journal.sh
chmod +x ~/.scripts/journal.sh
```

接着编辑 `~/.scripts/journal.sh`，把顶部的 `JOURNAL_DIR`、`TEMPLATE` 和 `EDITOR_CMD` 改成你的实际路径和常用编辑器。

然后把 alias 加到 shell 配置（`~/.zshrc` 或 `~/.bashrc`）：

```bash
echo "alias jrn='~/.scripts/journal.sh'" >> ~/.zshrc
source ~/.zshrc
```

之后你只需要输入 `jrn`，就能打开今天的日记。

### 5. 建好你的 life directory

把 starter files 复制到你想存放个人系统的目录里。下面示例默认你会放在 `~/Documents/[yourname]/`：

```bash
# Copy the numbered life-system areas
cp -r 00-09-system 10-19-planning 20-29-journal 30-39-knowledge 40-49-relationships 50-59-capture ~/Documents/yourname/

# Copy templates into the same numbered structure
mkdir -p ~/Documents/yourname/90-99-system
cp -r 90-99-system/91-templates ~/Documents/yourname/90-99-system/
```

别忘了同步更新你自己的 `CLAUDE.md` 里的路径。

### 6. 初始化 git（可选，但很推荐）

```bash
cd ~/Documents/yourname
git init
git add -A
git commit -m "Initial life system setup"
```

这样你的人生规划、年度目标、决策记录都会有版本历史。

### 7. 开始使用

```bash
cd ~/Documents/yourname
claude
```

输入 `morning` 或 `let's plan the day`，Claude 就会带你走一遍晨间流程：回顾昨天、明确今天重点，并检查你今天的行动是否真的连回年度目标和人生规划。

## 日常怎么运转

### 早晨

在你的 life directory 里打开 Claude Code，然后说 `morning` 或 `let's plan today`。Claude 会：

- 回顾昨天的日记
- 用模板创建今天的日记
- 问你富兰克林的晨间问题：**“今天我该做些什么有益的事？”**
- 检查你今天的优先级是否真的对齐年度目标

### 白天

- **自动记录**：你们一起工作时，Claude 会把值得记录的内容追加进日记
- **收件箱捕捉**：临时冒出来的任务和想法先进入 `50-59-capture/51-inbox/inbox.md`
- **决策记录**：遇到重要选择时，Claude 会帮你拆清楚，并在 `30-39-knowledge/32-decisions/` 创建决策文档
- **人物笔记**：见人前让 Claude 帮你做功课，它会把结构化信息放进 `40-49-relationships/41-people/`
- **研究笔记**：想深入理解某个主题时，Claude 会把结论和来源整理到 `30-39-knowledge/33-research/`

### 晚上

- 回答富兰克林的晚间问题：**“今天我做了哪些有益的事？”**
- 简短复盘：今天发生了什么，和早上计划的差距在哪里

## 这套系统真正有效的原因

之所以有效，是因为 Claude 每次开始前都会先读你写过的人生规划、年度目标和价值观。它会拿你自己说过“重要”的东西来约束你。

如果你每天的行动开始偏离年度目标，它会指出来；如果年度目标又开始偏离你的人生规划，它也会指出来。

文件本身才是事实来源。Claude 只是那个不会忘记你写过什么、并且会追问你的 accountability partner。

## Wiki-Links

文件之间可以用 `[[wiki-links]]` 互相引用。比如，某篇日记里写了 `和 [[张三]] 聊了这个项目`，Claude 就会去找 `40-49-relationships/41-people/张三.md`，并把上下文带回来。

之所以可行，是因为 `CLAUDE.md` 里约定了：当 Claude 遇到 `[[link]]` 时，要去 `40-49-relationships/41-people/`、`30-39-knowledge/33-research/`、`30-39-knowledge/32-decisions/`、`20-29-journal/21-daily/` 和 `30-39-knowledge/31-reference/` 这些目录里找对应文件。不需要特殊编辑器——这本质上只是 Claude 理解的一种约定。

你可以用它来建立这些连接：

- **日记** → **人物**：`和 [[张三]] 喝了杯咖啡`
- **决策** → **研究**：`依据 [[市场分析]]`
- **研究** → **人物**：`由 [[张三]] 主导`

注意：在大多数 Markdown 编辑器里（GitHub、iA Writer、VS Code），这些通常不会直接显示成可点击链接。它更像是给 Claude 和你自己看的文本约定。如果你用 [Obsidian](https://obsidian.md)，它会原生识别。

## 你可以按自己习惯改

这里所有内容都只是起点。没感觉的删掉，有帮助的加上：

- 不喜欢富兰克林问题？直接从模板里删掉
- 想做每周复盘？加一个 `week-WW.md` 模板
- 你的晨间流程不一样？改 `30-39-knowledge/31-reference/habits.md`
- `CLAUDE.md` 里的 philosophy 部分，本质上是在定义你和 Claude 的关系，把它写成你自己的版本

## 可选：用 QMD 做全文搜索

当你的日记、决策和笔记积累起来之后，你很快会遇到一个问题：不想每次都手动翻几十个文件。[QMD](https://github.com/tobi/qmd) 是一个本地 Markdown CLI 搜索引擎，支持关键词搜索（BM25）、语义 / 向量搜索，以及带 reranking 的混合查询。

### 安装 QMD

```bash
# Install via Homebrew
brew install tobi/tap/qmd

# Index your life directory
cd ~/Documents/yourname
qmd update    # Build keyword index
qmd embed     # Generate vector embeddings for semantic search
```

### 把 QMD 配成 MCP server

把 QMD 加进 Claude Code 的 MCP 配置，这样 Claude 就能直接搜索你的笔记。把下面这段加到 `~/.claude/settings.json` 的 `mcpServers` 下：

```json
{
  "mcpServers": {
    "qmd": {
      "command": "qmd",
      "args": ["mcp"],
      "cwd": "/Users/yourname/Documents/yourname"
    }
  }
}
```

### Claude 怎么使用 QMD

配置好之后，可以把下面这段加进你的 `CLAUDE.md`，让 Claude 知道什么时候该用它：

```markdown
### Searching Documents

Use **QMD** to search across journals, decisions, plans, and inbox:

- `search` — keyword/BM25, fast, good for specific terms
- `vsearch` — semantic/vector, good for "what have I said about X" or thematic queries
- `query` — hybrid (BM25 + vector + reranking), best for important searches
- `get` / `multi_get` — retrieve full document content by path

Read files directly when you already know the exact path.
```

### 记得定期刷新索引

QMD 不会自动更新。你可以定期运行 `qmd update && qmd embed`，也可以把它加进 morning skill（比如 Step 0），让每次开始前都自动重建索引。
