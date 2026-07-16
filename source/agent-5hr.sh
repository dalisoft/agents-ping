#!/bin/sh
set -eu

MESSAGE="hey bro. do not respond or do not do any tasks. this message is like PING"
ACTIVE_DIR=$(mktemp -d) || exit 1
FAILED=0

trap 'rm -rf "$ACTIVE_DIR"' 0
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

cd "$ACTIVE_DIR" || exit 1

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
}

run_ping() {
  name="$1"
  shift

  if output=$("$@" 2>&1); then
    status=0
  else
    status=$?
  fi

  if [ "$status" -eq 0 ]; then
    log "$name ping completed"
  else
    log "$name ping failed (exit $status)"
    printf '%s\n' "$output" >&2
    FAILED=1
  fi
}

log "Starting agent pings"

# Antigravity trigger 5-hour
run_ping "Antigravity" \
  agy \
  --model 'Gemini 3.5 Flash (Low)' \
  --mode plan \
  --print "$MESSAGE"

# Codex trigger 5-hour
run_ping "Codex" \
  codex \
  --model "gpt-5.6-luna" \
  --sandbox "read-only" \
  --ask-for-approval "never" \
  --cd "$ACTIVE_DIR" \
  exec --skip-git-repo-check \
  --ephemeral \
  "$MESSAGE"

# Claude trigger 5-hour
run_ping "Claude" \
  claude \
  --model "sonnet" \
  --permission-mode plan \
  --safe-mode \
  --no-chrome \
  --tools "" \
  --no-session-persistence \
  --print "$MESSAGE"

# CommandCode trigger 5-hour
run_ping "CommandCode" \
  cmd \
  --model "deepseek/deepseek-v4-pro" \
  --permission-mode plan \
  --skip-onboarding \
  --add-dir "$ACTIVE_DIR" \
  --print "$MESSAGE"

# OpenCode trigger 5-hour
run_ping "OpenCode" \
  opencode run \
  --model "opencode-go/deepseek-v4-pro" \
  --dir "$ACTIVE_DIR" \
  "$MESSAGE"

# OpenCode Z.AI Coding trigger 5-hour
run_ping "OpenCode Z.AI" \
  opencode run \
  --model "zai-coding-plan/glm-5.2" \
  --dir "$ACTIVE_DIR" \
  "$MESSAGE"

if [ "$FAILED" -eq 0 ]; then
  log "Finished agent pings"
else
  log "Failed agent pings"
fi

exit "$FAILED"
