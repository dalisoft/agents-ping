#!/bin/sh
set -eu

# Create (if not exists) directory
mkdir -p "${HOME}/.local/cron"

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

# Copy requires files
cp "./build/${APP_ID}.plist" "${PLIST}"
cp "./build/${SCRIPT_ID}.sh" "${SCRIPT}"

# Clear existing logs.
: >"$OUT_LOG"
: >"$ERR_LOG"
chmod 600 "$OUT_LOG" "$ERR_LOG"

# Validate.
chmod 700 "${SCRIPT}"
chmod 600 "${PLIST}"
plutil -lint "${PLIST}"

# Add/Re-add; RunAtLoad starts it automatically.
launchctl bootstrap "gui/${USER_ID}" "${PLIST}"

# Confirm status.
launchctl print "${TARGET}"
