# Custom Daemon Agents

[![Project Tracker](https://img.shields.io/badge/repo%20status-Project%20Tracker-lightgrey)](https://hthompson.dev/project-tracker#project-822761452)

A collection of custom macOS LaunchAgents and supporting scripts for automating user-level tasks. These agents are designed to run in the user's context, providing automation without requiring root privileges.

<details>
<summary><strong>Table of Contents</strong></summary>

- [Custom Daemon Agents](#custom-daemon-agents)
  - [Directory Structure](#directory-structure)
  - [User Agents](#user-agents)
    - [How to Use](#how-to-use)
      - [Notes](#notes)
  - [System Daemons](#system-daemons)
  - [Troubleshooting](#troubleshooting)
  - [License](#license)

</details>


## Directory Structure

```
custom-daemon-agents/
├── agent-scripts/         # AppleScript and shell scripts executed by agents
│   ├── logitech-monitor.scpt
│   └── mouse-monitor.scpt
├── launch-agents/         # User-level LaunchAgent .plist files
│   ├── local.StrangeRanger.LogitechMonitor.plist
│   └── local.StrangeRanger.MouseMonitor.plist
├── LICENSE
└── README.md
```

## User Agents

These LaunchAgents start automatically upon login, running scripts within your user context (non-root).

### How to Use

The default directory `~/.agent-scripts/` ensures user-level scripts remain organized and separate from system files.

1. Create a directory to store the scripts executed by the agent:
    ```bash
    mkdir -p ~/.agent-scripts/
    cp agent-scripts/* ~/.agent-scripts/
    ```
2. Copy the desired `.plist` file(s):
    ```bash
    cp launch-agents/local.StrangeRanger.LogitechMonitor.plist ~/Library/LaunchAgents/
    cp launch-agents/local.StrangeRanger.MouseMonitor.plist ~/Library/LaunchAgents/
    ```
3. Load (enable) the agent(s) using `launchctl`:
    ```bash
    launchctl load ~/Library/LaunchAgents/local.StrangeRanger.LogitechMonitor.plist
    launchctl load ~/Library/LaunchAgents/local.StrangeRanger.MouseMonitor.plist
    ```
4. If you use a different script directory, update the `ProgramArguments` path in the `.plist` file.

#### Notes

- Scripts must be executable (`chmod +x ~/.agent-scripts/*`).
- Paths in `.plist` files must match actual script locations.

## System Daemons

Currently, this repository contains only user-level agents, not system daemons (managed via `/Library/LaunchDaemons`).

## Troubleshooting

- After copying and loading a new agent, you may need to log out and back in for changes to take effect.
- Use `launchctl list | grep StrangeRanger` to check agent status. If the agent is not listed, it may not have been loaded correctly.
- Check `~/Library/Logs/` or `Console.app` for agent/script errors.
- Ensure scripts are executable: `chmod +x ~/.agent-scripts/*`

## License

This project is licensed under the [MIT License](LICENSE).
