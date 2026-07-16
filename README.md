# Agents Ping

A launchd-based hourly AI-agent pinger for macOS.

Pings your AI Agents each hour to keep your 5-hour active all the time.

## Features

- Simple, fast and easy
- Call via `command` (safe)
- Uses Agent CLI invocations
- Customizable (see `build/` folder)

## Limitations

- Automatic calling supports only on macOS
- Manually running `agent-5hr.sh` works across all OS

## Supported Agents

Currently supports these agents

- Antigravity
- Claude Code
- Codex
- Command Code
- Grok
- OpenCode

## Installation

### Install

First build script and plist by running `sh ./build.sh`.

And then run `sh ./install.sh`.

### Uninstall

Just run `sh ./uninstall.sh`

## FAQ

### `Unknown: FileSystem.readFile (/Users/dalisoft/.config/opencode/opencode.json)`

1. Open **System Settings** → **Privacy & Security** → **Files & Folders**.
2. If `opencode` appears, enable **Desktop Folder**.
3. If `opencode` absent, add manually.

### How to change call period

1. Edit [entry](./build/com.dalisoft.agent-pings.plist)
1. If missing this file, run `sh ./build.sh`
1. Ask any agent about change this part:

```plist
<key>StartCalendarInterval</key>
    <dict>
      <key>Minute</key>
      <integer>0</integer>
    </dict>
```

### Full re-build and re-install

Just run `./uninstall.sh && ./build.sh && ./install.sh`

## License

MIT
