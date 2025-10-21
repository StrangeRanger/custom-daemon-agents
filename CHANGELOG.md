# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [2025.8.10] – 2025‑08‑10

### Added

- Comprehensive README rewrite: added overview of macOS `launchd`, a collapsible table of contents, a table of existing jobs, troubleshooting steps, additional resources, and support notes.
- Modern usage instructions using `launchctl bootstrap`, `enable` and `kickstart`; retained legacy `load` commands.

### Changed

- Updated copy instructions to handle all `.plist` files at once and clarified the need to replace `hunter` with the user's name.
- Refined wording throughout README and renamed the project to "Custom macOS Daemons and Agents".

### Fixed

- Removed stray blank line at end‑of‑file in both LaunchAgent plists.

## [2025.7.26] – 2025‑07‑26

### Added

- Added `agentPlist`, `vendorID`, `appName` and `appPath` variables to both monitor scripts, making configuration explicit.
- Added error‑handling `try…on error` blocks around USB detection; on failure, display a dialog and unload the agent via `launchctl`.

### Changed

- Rewrote AppleScripts to clarify comments and separate variables from logic.
- Moved error handling from external shell scripts into the AppleScript itself, simplifying the environment (no more wrapper `.bash` scripts).

### Fixed

- Prevented runaway launchd retries by unloading the agent after an error.

## [2025.3.13] – 2025‑03‑13

### Fixed

- Corrected `local.StrangeRanger.LogitechMonitor.plist` and `local.StrangeRanger.MouseMonitor.plist` to use `<ProgramArguments>` instead of `<Program>` per launchd guidelines. The change encloses the AppleScript path in an array.

## [2024.12.30] – 2024‑12‑30

### Added
- Initial monitor scripts (`logitech-monitor.scpt` and `mouse-monitor.scpt`) that launch Logitech G Hub or Mos when specific USB devices are connected.
- Added detailed comments and variables for vendor IDs, app names and paths; included `try…on error` handlers that display an alert and unload the agent on failure.
- Introduced LaunchAgent plist files using the new naming convention `local.StrangeRanger.*` and `ProgramArguments` arrays.
- Added README with instructions on copying scripts to `~/.agent‑scripts`, copying plists to `~/Library/LaunchAgents` and loading them with `launchctl load`.

[unreleased]: https://github.com/StrangeRanger/bash-style-guide/compare/2025.10.21...HEAD
[2025.10.21]: https://github.com/StrangeRanger/bash-style-guide/releases/tag/2025.10.21
[2025.8.10]: https://github.com/StrangeRanger/bash-style-guide/releases/tag/2025.8.10
[2025.7.26]: https://github.com/StrangeRanger/bash-style-guide/releases/tag/2025.7.26
[2025.3.13]: https://github.com/StrangeRanger/bash-style-guide/releases/tag/2025.3.13
[2024.12.30]: https://github.com/StrangeRanger/bash-style-guide/releases/tag/2024.12.30
