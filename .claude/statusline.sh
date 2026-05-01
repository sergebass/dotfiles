#!/usr/bin/env bash
# Claude Code status line — mirrors starship prompt style
input=$(cat)

user=$(whoami)
host=$(hostname)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
time_now=$(date +%H:%M:%S)

used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used" ]; then
    context_str=$(printf "  Context %.0f%%" "$used")
else
    context_str=""
fi

five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
limits=""
[ -n "$five" ] && limits=" 5h:$(printf '%.0f' "$five")%"
[ -n "$week" ] && limits="$limits 7d:$(printf '%.0f' "$week")%"

cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
if [ -n "$cost_usd" ] && [ "$cost_usd" != "0" ]; then
    cost=$(printf "  💰 %.2f" "$cost_usd")
else
    cost=""
fi

effort=$(echo "$input" | jq -r '.effort.level // empty')
thinking=$(echo "$input" | jq -r '.thinking.enabled // empty')
params=""
[ -n "$effort" ] && params=" 🧠 $effort"
[ "$thinking" = "true" ] && params="$params (thinking)"

duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')
session_time=""
if [ -n "$duration_ms" ] && [ "$duration_ms" != "0" ]; then
    total_sec=$(( duration_ms / 1000 ))
    hours=$(( total_sec / 3600 ))
    mins=$(( (total_sec % 3600) / 60 ))
    days=$(( hours / 24 ))
    hours=$(( hours % 24 ))
    if [ "$days" -gt 0 ]; then
        session_time=$(printf "  %dd %dh %dm" "$days" "$hours" "$mins")
    elif [ "$hours" -gt 0 ]; then
        session_time=$(printf "  %dh %dm" "$hours" "$mins")
    else
        session_time=$(printf "  %dm" "$mins")
    fi
fi

printf "✻  \033[1;32m%s\033[0m\033[1;35m@%s\033[0m: \033[1;36m%s\033[0m  \033[1;33m%s\033[0m  \033[1;37m%s\033[0m  \033[1;31m%s%s%s%s%s%s\033[0m" \
    "$user" "$host" "$cwd" "$branch" "$time_now" "$model" "$params" "$context_str" "$limits" "$cost" "$session_time"
