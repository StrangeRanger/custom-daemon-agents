# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [2025.10.21] – 2025‑10‑21

*Changelog generated with GPT Codex*

### Added

- Added a **Supported macOS Versions** section to the README, explaining that macOS 26 is supported and that older systems (≤ macOS 15) should use a legacy branch. The section includes a table showing version status.

### Changed

- Updated the AppleScript monitor scripts to call `system_profiler SPUSBHostDataType` instead of `SPUSBDataType`, ensuring compatibility with macOS 26.
- Replaced the use of Mos with LinearMouse in `mouse-monitor.scpt` and adjusted the `appName`/`appPath` variables accordingly; the README job table was updated to reflect this.
- Simplified the descriptions and comments at the top of both AppleScript files; removed user‑facing error alerts and agent unloading, so errors no longer display a modal alert.
- Removed the `<key>Disabled</key>` entries from both LaunchAgent plists to rely on launchd defaults.
- Clarified README instructions for substituting your username in plist files and replaced `<plist>` placeholders with `PLIST_FILE.plist` to avoid confusion.
- Updated troubleshooting examples in the README to use `SPUSBHostDataType` and simplified the example output.

### Fixed

- AppleScript monitor scripts now work on macOS 26 by using `SPUSBHostDataType`.

## [2025.8.10] – 2025‑08‑10

*Changelog generated with GPT Codex*

### Added

- Comprehensive README rewrite: added overview of macOS `launchd`, a collapsible table of contents, a table of existing jobs, troubleshooting steps, additional resources, and support notes.
- Modern usage instructions using `launchctl bootstrap`, `enable` and `kickstart`; retained legacy `load` commands.

### Changed

- Updated copy instructions to handle all `.plist` files at once and clarified the need to replace `hunter` with the user's name.
- Refined wording throughout README and renamed the project to "Custom macOS Daemons and Agents".

### Fixed

- Removed stray blank line at end‑of‑file in both LaunchAgent plists.

## [2025.7.26] – 2025‑07‑26

*Changelog generated with GPT Codex*

### Added

- Added `agentPlist`, `vendorID`, `appName` and `appPath` variables to both monitor scripts, making configuration explicit.
- Added error‑handling `try…on error` blocks around USB detection; on failure, display a dialog and unload the agent via `launchctl`.

### Changed

- Rewrote AppleScripts to clarify comments and separate variables from logic.
- Moved error handling from external shell scripts into the AppleScript itself, simplifying the environment (no more wrapper `.bash` scripts).

### Fixed

- Prevented runaway launchd retries by unloading the agent after an error.

## [2025.3.13] – 2025‑03‑13

*Changelog generated with GPT Codex*

### Fixed

- Corrected `local.StrangeRanger.LogitechMonitor.plist` and `local.StrangeRanger.MouseMonitor.plist` to use `<ProgramArguments>` instead of `<Program>`. The change encloses the AppleScript path in an array.

## [2024.12.30] – 2024‑12‑30

*Changelog generated with GPT Codex*

### Added

- Initial monitor scripts (`logitech-monitor.scpt` and `mouse-monitor.scpt`) that launch Logitech G Hub or Mos when specific USB devices are connected.
- Added detailed comments and variables for vendor IDs, app names and paths; included `try…on error` handlers that display an alert and unload the agent on failure.
- Introduced LaunchAgent plist files using the new naming convention `local.StrangeRanger.*`.
- Added README with instructions on copying scripts to `~/.agent‑scripts`, copying plists to `~/Library/LaunchAgents` and loading them with `launchctl load`.

## [2024.7.1] – 2024‑07‑01

Initial release...

[unreleased]: https://github.com/StrangeRanger/custom-daemon-agents/compare/2025.10.21...HEAD
[2025.10.21]: https://github.com/StrangeRanger/custom-daemon-agents/releases/tag/2025.10.21
[2025.8.10]: https://github.com/StrangeRanger/custom-daemon-agents/releases/tag/2025.8.10
[2025.7.26]: https://github.com/StrangeRanger/custom-daemon-agents/releases/tag/2025.7.26
[2025.3.13]: https://github.com/StrangeRanger/custom-daemon-agents/releases/tag/2025.3.13
[2024.12.30]: https://github.com/StrangeRanger/custom-daemon-agents/releases/tag/2024.12.30
[2024.7.1]: https://github.com/StrangeRanger/custom-daemon-agents/releases/tag/2024.7.1
