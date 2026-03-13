#!/bin/bash

# 日记快速打开脚本
# 打开今天的日记；如果不存在，就基于模板创建
# 如果中间断了几天，会自动补齐缺失日期，并带上日历事件和未完成事项
#
# 配置方法：
#   1. 修改下面的 JOURNAL_DIR 和 TEMPLATE，使它们匹配你的实际路径
#   2. 对这个文件执行 chmod +x
#   3. 在 shell 里加上：alias jrn='~/.scripts/journal.sh'
#   4. （可选）如果要集成日历，安装 icalBuddy：brew install ical-buddy

JOURNAL_DIR="$HOME/Documents/YOURNAME/20-29-journal/21-daily"
TEMPLATE="$HOME/Documents/YOURNAME/90-99-system/91-templates/daily-journal.md"

# 编辑器命令——改成你习惯的编辑器（例如 "cursor"、"vim"、"open -a Obsidian"）
EDITOR_CMD="code"

# 要纳入的日历名称（仅在安装了 icalBuddy 时使用）
CALENDAR_NAMES="Work,Personal,Family"

# 获取今天的日期
TODAY=$(date +%Y-%m-%d)

# 找到最近一篇日记（最多向前回看 60 天）
find_most_recent_journal_date() {
    for i in $(seq 1 60); do
        PAST_DATE=$(date -v-${i}d +%Y-%m-%d)
        PAST_YEAR=$(date -v-${i}d +%Y)
        PAST_MONTH=$(date -v-${i}d +%m)
        PAST_FILE="$JOURNAL_DIR/$PAST_YEAR/$PAST_MONTH/$PAST_DATE.md"
        if [ -f "$PAST_FILE" ]; then
            echo "$PAST_DATE"
            return
        fi
    done
}

# 获取某一天的日历事件（仅 macOS，且需要 icalBuddy）
get_calendar_events() {
    local TARGET_DATE="$1"
    if command -v icalBuddy &> /dev/null; then
        icalBuddy -nc -nrd -ic "$CALENDAR_NAMES" -eep "notes,location,url,attendees" -tf "%H:%M" -df "" eventsFrom:"$TARGET_DATE" to:"$TARGET_DATE" 2>/dev/null | python3 -c "
import sys
import re

lines = sys.stdin.read().strip().split('\n')
results = []
i = 0
while i < len(lines):
    line = lines[i].strip()
    if line.startswith('• '):
        title = line[2:]
        i += 1
        if i < len(lines):
            time_line = lines[i].strip()
            match = re.match(r'(\d{2}:\d{2}) - (\d{2}:\d{2})', time_line)
            if match:
                start, end = match.groups()
                sh, sm = map(int, start.split(':'))
                eh, em = map(int, end.split(':'))
                dur = (eh * 60 + em) - (sh * 60 + sm)
                if dur >= 60:
                    h, m = divmod(dur, 60)
                    dur_str = f'{h}h {m}m' if m else f'{h}h'
                else:
                    dur_str = f'{dur}m'
                results.append(f'- {start} - {title} ({dur_str})')
    i += 1
print('\n'.join(results))
" 2>/dev/null
    fi
}

# 从一篇日记里提取未完成事项
get_incomplete_todos() {
    local FILE="$1"
    if [ -f "$FILE" ]; then
        grep -E '^\s*- \[ \]' "$FILE" 2>/dev/null | head -n 20 || true
    fi
}

# 从一篇日记里提取仍在进行中的决策事项
get_active_decisions() {
    local FILE="$1"
    if [ -f "$FILE" ]; then
        sed -n '/^## Active Decisions/,/^## /p' "$FILE" 2>/dev/null | \
            grep -E '^\s*- \[ \]' 2>/dev/null || true
    fi
}

# 为指定日期创建日记
create_journal_entry() {
    local TARGET_DATE="$1"
    local PREV_FILE="$2"

    local TARGET_YEAR=$(echo "$TARGET_DATE" | cut -d'-' -f1)
    local TARGET_MONTH=$(echo "$TARGET_DATE" | cut -d'-' -f2)
    local TARGET_FILE="$JOURNAL_DIR/$TARGET_YEAR/$TARGET_MONTH/$TARGET_DATE.md"

    # 如果已经存在，就直接跳过
    if [ -f "$TARGET_FILE" ]; then
        echo "$TARGET_FILE"
        return
    fi

    # 确保目标目录存在
    mkdir -p "$(dirname "$TARGET_FILE")"

    # 从前一天文件里取出未完成事项
    local PAST_TODOS=""
    if [ -n "$PREV_FILE" ]; then
        PAST_TODOS=$(get_incomplete_todos "$PREV_FILE")
    fi

    # 从前一天文件里取出仍在进行中的决策
    local PAST_DECISIONS=""
    if [ -n "$PREV_FILE" ]; then
        PAST_DECISIONS=$(get_active_decisions "$PREV_FILE")
    fi

    # 获取这一天的日历事件
    local CALENDAR_EVENTS=$(get_calendar_events "$TARGET_DATE")

    # 读取模板并替换占位符
    if [ -f "$TEMPLATE" ]; then
        local CONTENT=$(cat "$TEMPLATE")
        CONTENT="${CONTENT//\{\{DATE\}\}/$TARGET_DATE}"

        if [ -n "$PAST_TODOS" ]; then
            CONTENT="${CONTENT//\{\{PAST_TODOS\}\}/$PAST_TODOS}"
        else
            CONTENT="${CONTENT//\{\{PAST_TODOS\}\}/}"
        fi

        if [ -n "$CALENDAR_EVENTS" ]; then
            CONTENT="${CONTENT//\{\{CALENDAR\}\}/$CALENDAR_EVENTS}"
        else
            CONTENT="${CONTENT//\{\{CALENDAR\}\}/}"
        fi

        if [ -n "$PAST_DECISIONS" ]; then
            CONTENT="${CONTENT//\{\{PAST_DECISIONS\}\}/$PAST_DECISIONS}"
        else
            CONTENT="${CONTENT//\{\{PAST_DECISIONS\}\}/}"
        fi

        echo "$CONTENT" > "$TARGET_FILE"
    fi

    echo "$TARGET_FILE"
}

# 计算两个日期之间相差多少天（macOS）
days_between() {
    local START_DATE="$1"
    local END_DATE="$2"
    local START_SEC=$(date -j -f "%Y-%m-%d" "$START_DATE" "+%s")
    local END_SEC=$(date -j -f "%Y-%m-%d" "$END_DATE" "+%s")
    echo $(( (END_SEC - START_SEC) / 86400 ))
}

# 主流程
MOST_RECENT_DATE=$(find_most_recent_journal_date)

if [ -n "$MOST_RECENT_DATE" ]; then
    DAYS_MISSING=$(days_between "$MOST_RECENT_DATE" "$TODAY")

    if [ "$DAYS_MISSING" -gt 0 ]; then
        PREV_YEAR=$(echo "$MOST_RECENT_DATE" | cut -d'-' -f1)
        PREV_MONTH=$(echo "$MOST_RECENT_DATE" | cut -d'-' -f2)
        PREV_FILE="$JOURNAL_DIR/$PREV_YEAR/$PREV_MONTH/$MOST_RECENT_DATE.md"

        # 为每个缺失日期创建日记（从最近一篇之后那天开始补）
        for i in $(seq $((DAYS_MISSING - 1)) -1 0); do
            TARGET_DATE=$(date -v-${i}d +%Y-%m-%d)
            PREV_FILE=$(create_journal_entry "$TARGET_DATE" "$PREV_FILE")
        done
    fi
else
    # 如果之前没有任何日记，就只创建今天这篇
    create_journal_entry "$TODAY" ""
fi

# 组装今天的文件路径并打开
TODAY_YEAR=$(date +%Y)
TODAY_MONTH=$(date +%m)
TODAY_FILE="$JOURNAL_DIR/$TODAY_YEAR/$TODAY_MONTH/$TODAY.md"

$EDITOR_CMD "$TODAY_FILE"
