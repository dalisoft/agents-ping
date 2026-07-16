#!/bin/sh
set -eu

# Variables
USER_ID="$(id -u)"
APP_ID="com.dalisoft.agent-pings"
SCRIPT_ID="agent-5hr"
TARGET="gui/${USER_ID}/${APP_ID}"

PLIST="${HOME}/Library/LaunchAgents/${APP_ID}.plist"
SCRIPT="${HOME}/.local/cron/${SCRIPT_ID}.sh"

OUT_LOG="${HOME}/.local/cron/${SCRIPT_ID}.out.log"
ERR_LOG="${HOME}/.local/cron/${SCRIPT_ID}.err.log"

# Stop and unload
launchctl kill SIGTERM "$TARGET" 2>/dev/null || true
launchctl bootout "$TARGET" 2>/dev/null || true

# Remove files
rm -f "$PLIST" "$SCRIPT" "$OUT_LOG" "$ERR_LOG"
