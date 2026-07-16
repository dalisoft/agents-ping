#!/bin/sh
set -eu

# Prune old files
rm -rf build
mkdir build

# Copy files to temp folder
cp -r "source/" "build/"
# Set current user

# Set App ID
sed -i '' -e "s/%user%/$USER/" build/com.dalisoft.agent-pings.plist
sed -i '' -e "s/%app_id%/agent-5hr/" build/com.dalisoft.agent-pings.plist

# Set permission to avoid issues
chmod +x source/agent-5hr.sh
