# Agents Ping

Agents ping cron task for macOS.

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

First build script and plist by running `sh ./build.sh`.

And then run `sh ./install.sh`.

## Uninstall

Just run `sh ./uninstall.sh`

## License

MIT
