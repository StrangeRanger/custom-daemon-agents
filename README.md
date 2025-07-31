# Custom Daemon Agents

[![Project Tracker](https://img.shields.io/badge/repo%20status-Project%20Tracker-lightgrey)](https://hthompson.dev/project-tracker#project-822761452) [![GitHub License](https://img.shields.io/github/license/StrangeRanger/custom-daemon-agents)](LICENSE)

A collection of custom macOS LaunchAgents and supporting scripts for automating user-level tasks. These agents are designed to run in the user's context, providing automation without requiring root privileges.

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

The `launch-agents` directory contains LaunchAgents that run within the user's context. These agents start when the user logs in, do not run as root, and do not require elevated privileges.

### How to Use

1. Create a directory to store the scripts executed by the agent (default: `~/.agent-scripts/`):
    ```bash
    mkdir -p ~/.agent-scripts/
    cp agent-scripts/* ~/.agent-scripts/
    ```

2. Copy the desired `.plist` file to your LaunchAgents directory (`~/Library/LaunchAgents`):
    ```bash
    cp launch-agents/local.StrangeRanger.LogitechMonitor.plist ~/Library/LaunchAgents/
    cp launch-agents/local.StrangeRanger.MouseMonitor.plist ~/Library/LaunchAgents/
    ```

3. Load (enable) the agent using `launchctl`:
    ```bash
    launchctl load ~/Library/LaunchAgents/local.StrangeRanger.LogitechMonitor.plist
    launchctl load ~/Library/LaunchAgents/local.StrangeRanger.MouseMonitor.plist
    ```

4. If you use a different directory for scripts, update the `ProgramArguments` or `Program` path in the relevant `.plist` file.

#### Notes

- All scripts used by the agents are available in the `agent-scripts` directory.
- Make sure the script paths in the `.plist` files are accurate for the agent to function correctly.
- You can edit the `.plist` files to adjust script paths, environment variables, or scheduling as needed.

## System Daemons

Currently, this repository does not contain any system daemons. System daemons run as root and are managed via `/Library/LaunchDaemons`.

## Troubleshooting

- After copying and loading a new agent, you may need to log out and back in for changes to take effect.
- Use `launchctl list | grep StrangeRanger` to check agent status. If the agent is not listed, it may not have loaded correctly.
- Check `~/Library/Logs/` or `Console.app` for agent/script errors.
- Ensure scripts are executable: `chmod +x ~/.agent-scripts/*`
