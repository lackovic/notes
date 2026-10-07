#!/bin/sh
input=$(cat)
eval "$(printf '%s' "$input" | python3 -I -c '
import json, sys, shlex, os
d = json.load(sys.stdin)
def g(o, *k):
    for x in k:
        o = o.get(x) if isinstance(o, dict) else None
    return "" if o is None else o
try:
    effort = json.load(open(os.path.expanduser("~/.claude/settings.json"))).get("effortLevel") or ""
except Exception:
    effort = ""
vals = {
    "cwd": g(d, "workspace", "current_dir"),
    "model_name": g(d, "model", "display_name"),
    "effort": effort,
    "used_pct": g(d, "context_window", "used_percentage"),
    "compression_count": g(d, "context_window", "compression_count") or 0,
    "total_input_tokens": g(d, "context_window", "total_input_tokens"),
    "window_size": g(d, "context_window", "context_window_size"),
    "cost": g(d, "cost", "total_cost_usd"),
}
for k, v in vals.items():
    print("%s=%s" % (k, shlex.quote(str(v))))
')"
host=$(hostname)
dir_name=$(basename "$cwd")
cd "$cwd" 2>/dev/null || exit 0

if git rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  if git diff-index --quiet HEAD -- 2>/dev/null; then
    status=""
  else
    status=" ✗"
  fi
  prompt_part=$(printf "➜  %s git:(%s)%s" "$dir_name" "$branch" "$status")
else
  prompt_part=$(printf "➜  %s" "$dir_name")
fi

if [ -n "$model_name" ]; then
  if [ -n "$effort" ]; then
    model_part=$(printf "🤖 %s (%s) | " "$model_name" "$effort")
  else
    model_part=$(printf "🤖 %s | " "$model_name")
  fi
else
  model_part=""
fi

if [ -n "$used_pct" ]; then
  used_int=$(printf "%.0f" "$used_pct")
  bar_width=10
  filled=$((used_int * bar_width / 100))
  empty=$((bar_width - filled))
  bar="["
  i=0
  while [ $i -lt $filled ]; do bar="${bar}█"; i=$((i+1)); done
  i=0
  while [ $i -lt $empty ]; do bar="${bar}░"; i=$((i+1)); done
  bar="${bar}]"
  fmt_tokens() {
    awk -v t="$1" 'BEGIN{if (t>=1000000) printf "%.1fM", t/1000000; else if (t>=1000) printf "%.0fk", t/1000; else printf "%d", t}'
  }
  context_part=$(printf " %s %d%%" "$bar" "$used_int")
  if [ -n "$total_input_tokens" ]; then
    used_fmt=$(fmt_tokens "$total_input_tokens")
    if [ -n "$window_size" ]; then
      context_part=$(printf " %s %s/%s %d%%" "$bar" "$used_fmt" "$(fmt_tokens "$window_size")" "$used_int")
    else
      context_part=$(printf " %s %s %d%%" "$bar" "$used_fmt" "$used_int")
    fi
  fi
  if [ "$compression_count" -gt 0 ]; then
    context_part=$(printf "%s (c%d)" "$context_part" "$compression_count")
  fi
else
  context_part=""
fi

if [ -n "$cost" ]; then
  cost_part=$(printf " | 💰 \$%.2f" "$cost")
else
  cost_part=""
fi

echo "🖥️  ${host} | ${model_part}${prompt_part}${context_part}${cost_part}"