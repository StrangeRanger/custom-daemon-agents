# Custom macOS Daemons and Agents

[![Project Tracker](https://img.shields.io/badge/repo%20status-Project%20Tracker-lightgrey)](https://hthompson.dev/project-tracker#project-822761452)

A collection of custom macOS LaunchAgents, LaunchDaemons, and supporting scripts for automating tasks.

If you are unfamiliar with `launchd` jobs, they are part of macOS's unified service management framework. `launchd` is the system’s init process, responsible for starting, stopping, and managing jobs — including system daemons, user agents, applications, and scripts — based on configuration and triggers.

If you are interested in learning more about `launchd`, daemons, agents, and related tools, check out the [Additional Resources](#additional-resources) section of this document.

<details>
<summary><strong>Table of Contents</strong></summary>

- [Custom macOS Daemons and Agents](#custom-macos-daemons-and-agents)
  - [Directory Structure](#directory-structure)
  - [Existing Agents and Daemons](#existing-agents-and-daemons)
  - [Launch Agents](#launch-agents)
    - [How to Use](#how-to-use)
  - [Launch Daemons](#launch-daemons)
  - [Troubleshooting](#troubleshooting)
  - [Additional Resources](#additional-resources)
  - [Support and Issues](#support-and-issues)
  - [License](#license)

</details>

## Directory Structure

Below is a brief overview of the repository's directory structure, to help you understand its organization:

```
custom-daemon-agents/
├── agent-scripts/  # AppleScript and shell scripts executed by launchd jobs
└── launch-agents/  # LaunchAgent plist files
```

## Existing Agents and Daemons

The table below lists the LaunchAgents, LaunchDaemons, and their associated scripts in this repository:

| `launchd` Job | Associated Script | Type | Description |
| ------------- | ----------------- | ---- | ----------- |
| `local.StrangeRanger.LogitechMonitor` | `logitech-monitor.scpt` | LaunchAgent | Opens [Logitech G Hub](https://www.logitechg.com/en-us/innovation/g-hub.html) when a Logitech USB device (Vendor ID `0x046d`) is detected. |
| `local.StrangeRanger.MouseMonitor` | `mouse-monitor.scpt` | LaunchAgent | Opens [Mos](https://mos.caldis.me/) when the configured mouse (by Product ID) is detected. |

## Launch Agents

These LaunchAgents start automatically upon login, running scripts within your user context.

### How to Use

1. Create a directory for the scripts, then copy them into it:
    ```bash
    mkdir -p ~/.agent-scripts/
    cp agent-scripts/* ~/.agent-scripts/
    ```
2. Copy the `.plist` files to `~/Library/LaunchAgents/`:
    ```bash
    cp launch-agents/* ~/Library/LaunchAgents/
    ```
3. Replace `hunter` with your username in the `.plist` files:
    ```bash
    sed -i '' -e 's/\/Users\/hunter/\/Users\/YOUR_USERNAME/' ~/Library/LaunchAgents/<plist>
    ```
4. Load and start the agent(s):
    - Modern (recommended on recent macOS):
        ```bash
        # Load the job
        launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/<plist>
        # Enable the job
        launchctl enable gui/$(id -u)/<Label>
        # (Re)start the job
        launchctl kickstart -k gui/$(id -u)/<Label>
        ```
   - Legacy (still works):
     ```bash
     launchctl load ~/Library/LaunchAgents/<plist>
     ```

> [!NOTE]
> - If you used a directory other than `~/.agent-scripts/`, update the `ProgramArguments` path(s) in the `.plist` file(s).

## Launch Daemons

Currently, this repository does not contain any LaunchDaemons.

## Troubleshooting

<details>
<summary><strong>The agent is not listed or didn’t start — how can I check status?</strong></summary>

> Use this to see if the job is loaded in your user domain:
>
> ```bash
> launchctl list | grep StrangeRanger
> ```
>
> If it’s not listed, load it using the steps in “How to Use.”

</details>

<details>
<summary><strong>How can I inspect details for a specific agent?</strong></summary>

> Print the runtime state and last exit status:
>
> ```bash
> launchctl print gui/$(id -u)/local.StrangeRanger.MouseMonitor
> launchctl print gui/$(id -u)/local.StrangeRanger.LogitechMonitor
> ```

</details>

<details>
<summary><strong>How do I unload, disable, or restart an agent?</strong></summary>

> Modern commands:
>
> ```bash
> # Stop/unload
> launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/<plist>
> # Disable so it won’t auto-start
> launchctl disable gui/$(id -u)/<Label>
> # (Re)start immediately
> launchctl kickstart -k gui/$(id -u)/<Label>
> ```
>
> Legacy alternative:
>
> ```bash
> launchctl unload ~/Library/LaunchAgents/<plist>
> launchctl load   ~/Library/LaunchAgents/<plist>
> ```

</details>

<details>
<summary><strong>Why am I seeing AppleScript alerts from these agents?</strong></summary>

> On fatal error, the scripts show an AppleScript alert and then unload the agent to avoid retry loops. Because they run as LaunchAgents (in your user session), alerts are allowed. If you prefer non‑interactive behavior, remove the alert from the script(s) and log the error instead.

</details>

<details>
<summary><strong>How do I find my device IDs (Vendor ID and Product ID)?</strong></summary>

> List connected USB devices and filter for IDs:
>
> ```bash
> system_profiler SPUSBDataType | grep -E "(Vendor ID|Product ID|Manufacturer)"
> ```
>
> Look for lines such as:
>
> ```
> Vendor ID: 0x1234 (Manufacturer Name)
> Product ID: 0xabcd
> ```
>
> Use those values to set the `vendorID` and/or `product ID` variables in the AppleScript(s) for your specific hardware.

</details>

## Additional Resources

- Man pages: `man launchctl`, `man launchd.plist`
- Apple documentation:
  - [Script management with launchd in Terminal on Mac](https://support.apple.com/guide/terminal/script-management-with-launchd-apdc6c1077b-5d5d-4d35-9c19-60f2397b2369)
  - [Creating Launch Daemons and Agents (Archived)](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html)
- Third party tools/info:
  - [LaunchControl](https://www.soma-zone.com/LaunchControl/) (tool)
  - [What is launchd?](https://www.launchd.info/) (info)

## Support and Issues

Please use [GitHub Issues](https://github.com/StrangeRanger/custom-daemon-agents/issues) for bug reports and feature requests.

## License

This project is licensed under the [MIT License](LICENSE).
