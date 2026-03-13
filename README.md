# 个人生活操作系统

一个面向 OpenClaw 的个人生活操作系统。灵感来自 Carmack 的 `.plan` 文件、富兰克林式自我修炼，以及 Johnny.Decimal 对“东西要放得快、找得快”的强调。

## 这是什么

这是一套纯文本的生活管理系统：用来做人生规划、每日记录、重要决策和任务捕捉，并让 OpenClaw 成为你的思考伙伴。没有 App，没有订阅，只有 Markdown 文件、终端，以及一个会适时提出质疑的 AI。

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
- **价值观与习惯** —— 把原则和日常节奏写下来，让 agent 能据此提醒你
- **人物笔记** —— 记录你要见面、合作或研究的人
- **研究笔记** —— 针对公司、技术、市场、概念等主题做深入整理

## 配置方法

### 1. 安装 OpenClaw

OpenClaw 官方目前要求 **Node ≥ 22**。

```bash
npm install -g openclaw@latest
openclaw onboard --install-daemon
```

推荐直接运行 onboarding 向导，它会带你初始化 gateway、workspace 和基础配置。

### 2. 把这个仓库设为 OpenClaw workspace

从这一版开始，推荐直接把**当前仓库根目录**作为 OpenClaw workspace 使用，而不是再复制出一个单独的个人系统目录。

- OpenClaw 默认的 workspace 根目录是 `~/.openclaw/workspace`
- 如果你想直接用这个仓库，可以在 onboarding 时把 workspace 指到当前仓库目录
- 或者之后在 `~/.openclaw/openclaw.json` 里把 `agents.defaults.workspace` 改成当前仓库根目录

从这一版开始，仓库里的规则、skill 和脚本都默认**以当前 workspace 根目录为基准路径**。

### 3. 修改 `AGENTS.md`

这个仓库根目录已经自带 `AGENTS.md`。它就是 OpenClaw 会注入到当前 workspace 的主规则文件。

你现在只需要**自己改一遍**：把占位符替换成你的名字、项目和偏好。重点就是让它真正变成“你的系统”。

仓库里仍然保留了 `CLAUDE.md`，但那只是给 Claude 风格宿主用的兼容副本；OpenClaw 本身优先读 `AGENTS.md`。

### 4. 定时 skills 已内置

这个仓库已经在根目录带好了 OpenClaw 运行时入口：

- `skills/morning/` —— 晨间启动
- `skills/midday/` —— 午间检查
- `skills/evening/` —— 晚间总结

你不需要再手动 copy skill；只需要按你的实际情况修改这些运行时文件。

这里的 `skills/` 也是 **唯一维护入口**。

### 5. 配置定时任务（推荐）

如果你的 OpenClaw 宿主或 IM 集成支持**重复定时任务**，把它设成这三个固定对话：

- **08:30**：发送 `morning`
- **12:30**：发送 `midday`
- **21:00**：发送 `evening`

不同版本、不同宿主的定时任务配置界面会变化，所以这里不把某个具体 JSON 或命令写死。你只需要记住核心映射：

- 早晨：`morning`
- 午间：`midday`
- 晚间：`evening`

本质上就是让 OpenClaw 替你按时发起三段对话，而不是依赖你自己记得输入某个口令。

### 6. git 维护（可选，但很推荐）

如果你是直接 `clone` / `fork` 这个仓库来用，可以继续沿用现有 git 历史。

如果你是把内容导出到一个新目录、没有 `.git`，再自己初始化：

```bash
git init
git add -A
git commit -m "Initialize my life system"
```

这样你的人生规划、年度目标、决策记录都会有版本历史。

### 7. 手动补跑（可选）

如果某次定时任务漏跑了，也可以手动补一条消息：

- `morning`
- `midday`
- `evening`

手动触发现在只是兜底方式，不再是默认主流程。

## 日常怎么运转

### 早晨

由 `morning` skill 发起。它会：

- 回顾昨天的日记
- 用模板创建今天的日记
- 问你富兰克林的晨间问题：**“今天我该做些什么有益的事？”**
- 检查你今天的优先级是否真的对齐年度目标

### 午间

由 `midday` skill 发起。它会：

- 回看上午真正发生了什么，而不是只看原计划
- 更新日记里的“午间检查”部分
- 收敛下午最重要的 1 到 2 件事
- 提醒你处理真正的阻塞，而不是继续逃避

### 白天

- **自动记录**：你们一起工作时，OpenClaw 会把值得记录的内容追加进日记
- **收件箱捕捉**：临时冒出来的任务和想法先进入 `50-59-capture/51-inbox/inbox.md`
- **决策记录**：遇到重要选择时，OpenClaw 会帮你拆清楚，并在 `30-39-knowledge/32-decisions/` 创建决策文档
- **人物笔记**：见人前让 OpenClaw 帮你做功课，它会把结构化信息放进 `40-49-relationships/41-people/`
- **研究笔记**：想深入理解某个主题时，OpenClaw 会把结论和来源整理到 `30-39-knowledge/33-research/`

### 晚上

由 `evening` skill 发起。它会：

- 回答富兰克林的晚间问题：**“今天我做了哪些有益的事？”**
- 简短复盘：今天发生了什么，和早上计划的差距在哪里
- 谨慎延续未完成事项，而不是机械复制到明天

## 这套系统真正有效的原因

之所以有效，是因为 OpenClaw 每次开始前都会先读你写过的人生规划、年度目标和价值观。它会拿你自己说过“重要”的东西来约束你。

如果你每天的行动开始偏离年度目标，它会指出来；如果年度目标又开始偏离你的人生规划，它也会指出来。

文件本身才是事实来源。OpenClaw 只是那个不会忘记你写过什么、并且会追问你的 accountability partner。

## Wiki-Links

文件之间可以用 `[[wiki-links]]` 互相引用。比如，某篇日记里写了 `和 [[张三]] 聊了这个项目`，OpenClaw 就会去找 `40-49-relationships/41-people/张三.md`，并把上下文带回来。

之所以可行，是因为 `AGENTS.md` 里约定了：当 agent 遇到 `[[link]]` 时，要去 `40-49-relationships/41-people/`、`30-39-knowledge/33-research/`、`30-39-knowledge/32-decisions/`、`20-29-journal/21-daily/` 和 `30-39-knowledge/31-reference/` 这些目录里找对应文件。不需要特殊编辑器——这本质上只是规则文件里的一种约定。

你可以用它来建立这些连接：

- **日记** → **人物**：`和 [[张三]] 喝了杯咖啡`
- **决策** → **研究**：`依据 [[市场分析]]`
- **研究** → **人物**：`由 [[张三]] 主导`

注意：在大多数 Markdown 编辑器里（GitHub、iA Writer、VS Code），这些通常不会直接显示成可点击链接。它更像是给 agent 和你自己看的文本约定。如果你用 [Obsidian](https://obsidian.md)，它会原生识别。

## 你可以按自己习惯改

这里所有内容都只是起点。没感觉的删掉，有帮助的加上：

- 不喜欢富兰克林问题？直接从模板里删掉
- 想做每周复盘？加一个 `week-WW.md` 模板
- 你的晨间流程不一样？改 `30-39-knowledge/31-reference/habits.md`
- `AGENTS.md` 里的 philosophy 部分，本质上是在定义你和 agent 的关系，把它写成你自己的版本

## 可选：用 QMD 做全文搜索

当你的日记、决策和笔记积累起来之后，你很快会遇到一个问题：不想每次都手动翻几十个文件。[QMD](https://github.com/tobi/qmd) 是一个本地 Markdown CLI 搜索引擎，支持关键词搜索（BM25）、语义 / 向量搜索，以及带 reranking 的混合查询。

### 安装 QMD

```bash
# 通过 Homebrew 安装
brew install tobi/tap/qmd

# 在当前 workspace 根目录建立索引
cd /path/to/this-repo
qmd update    # Build keyword index
qmd embed     # Generate vector embeddings for semantic search
```

### 把 QMD 接进 OpenClaw

OpenClaw 的默认配置目录在 `~/.openclaw/`，主配置文件是 `~/.openclaw/openclaw.json`。这部分配置变动比较快，所以这里**不把某个版本的 JSON 结构写死**；最稳妥的做法是按照当前版本 OpenClaw 的 configuration / MCP 文档，把 QMD 注册成可调用服务。

无论配置界面长什么样，核心信息都是：

- command：`qmd`
- args：`["mcp"]`
- cwd：当前 workspace 根目录（也就是这个仓库根目录）

### 让 `AGENTS.md` 知道什么时候用 QMD

配置好之后，可以把下面这段加进你的 `AGENTS.md`（如果你还维护 `CLAUDE.md` 兼容副本，也一起同步过去），让 agent 知道什么时候该用它：

```markdown
### 文档搜索

当需要跨 journal、decisions、plans 和 inbox 检索时，优先使用 **QMD**：

- `search` —— 关键词 / BM25，速度快，适合查具体词
- `vsearch` —— 语义 / 向量搜索，适合“我以前怎么想过 X”这类问题
- `query` —— 混合检索（BM25 + vector + reranking），适合重要搜索
- `get` / `multi_get` —— 已知路径时取回完整文档

如果你已经知道准确路径，就直接读文件，不必先搜索。
```

### 记得定期刷新索引

QMD 不会自动更新。你可以定期运行 `qmd update && qmd embed`，也可以把它加进早晨的 `morning` skill（比如 Step 0），让每天第一段定时检查开始前自动重建索引。

## 致谢

这套仓库的起点和灵感，来自以下两个来源：

- [davidhariri/life-system](https://github.com/davidhariri/life-system) —— 提供了把纯文本、规划、日志和 agent 协作结合起来的原始 starter kit。
- [Johnny.Decimal 方法介绍](https://johnnydecimal.com/10-19-concepts/11-core/11.01-introduction/) —— 提供了这次目录结构改造背后的核心组织理念。

这个仓库不是对它们的逐字复制，而是结合 OpenClaw、中文语境和我自己的使用方式做过调整后的版本。
