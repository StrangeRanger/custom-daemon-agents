-- Description:
-- 	Check if a Logitech USB device, then launch the Logitech G Hub application if the
--  device is connected and the app is not already running.
-- Purpose:
--  Logitech G Hub is used to configure Logitech gaming peripherals. I only want the
--  application to run when I'm using my Logitech devices, so I use this script + an
--  agent to launch the application when the mouse is connected.
-- Note:
--  There shouldn't be a need to change the vendorID, appName, or appPath variables.

-- Path to your LaunchAgent.
set agentPlist to POSIX path of (path to home folder) & "Library/LaunchAgents/local.user.LogitechMonitor.plist"
-- The USB vendor ID and app info.
set vendorID to "0x046d"
set appName to "lghub"
set appPath to "/Applications/lghub.app"

try
    -- Get USB list from system_profiler.
	set usbDevices to do shell script "system_profiler SPUSBDataType"
    -- Check if the vendor ID is present in the list.
    if usbDevices contains vendorID then
        -- Launch the application if it is not already running.
        if not application appName is running then
            do shell script "open " & quoted form of appPath
        end if
    end if
on error errMsg number errNum
    -- Display an error dialog if fetching USB devices fails.
    display alert "Error in Logitech Monitor script" ¬
        message errMsg & return & return & ¬
        "The LaunchAgent will now be unloaded to prevent further retries." ¬
        as warning buttons {"OK"} default button "OK"
    -- Unload the agent so launchd stops trying to rerun it.
    do shell script "launchctl unload " & quoted form of agentPlist
	return
end try
