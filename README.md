# Custom Daemon Agents

[![Project Tracker](https://img.shields.io/badge/repo%20status-Project%20Tracker-lightgrey)](https://hthompson.dev/project-tracker#project-822761452) [![GitHub License](https://img.shields.io/github/license/StrangeRanger/custom-daemon-agents)](LICENSE)

This repository contains the source code for custom Daemons and Agents created for macOS.

## User Agents

The `user-agents` directory contains user agents that run within the user's context. These agents start when the user logs in, do not run as root, and do not require elevated privileges.

### How to Use

1. Copy the desired `.plist` file to `~/Library/LaunchAgents`:
    ```bash
    cp com.example.agent.plist ~/Library/LaunchAgents/
    ```

2. Load (enable) the agent using `launchctl`:
    ```bash
    launchctl load ~/Library/LaunchAgents/com.example.agent.plist
    ```

3. Create a directory to store the scripts executed by the agent. By default, this repository uses `~/.agent-scripts/` for script storage. You can create the directory and move the necessary files as follows:
    ```bash
    mkdir -p ~/.agent-scripts/
    cp path/to/your/scripts ~/.agent-scripts/
    ```

4. Update the `.plist` file if you decide to use a different directory path.

### Notes
- All scripts used by the agents are available in the `agent-scripts` directory.
- Make sure the script paths in the `.plist` files are accurate for the agent to function correctly.

## System Daemons

Currently, this repository does not contain any system daemons.
