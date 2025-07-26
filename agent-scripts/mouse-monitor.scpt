-- Description:
-- 	Check if a specific USB device is connected, then launch the Mos application if the
--  device is connected and the app is not already running.
-- Purpose:
--  Mos makes it possible to reverse the direction of the scroll wheel on a mouse.
--  Because I only want the application to run when I'm using my mouse, I use this
--  script + an agent to launch the application when the mouse is connected.
-- Note:
--  The product ID is specific to my mouse. If you want to use this script, you need to
--  replace the product ID with the product ID of your mouse.

-- Path to your LaunchAgent.
set agentPlist to POSIX path of (path to home folder) & "Library/LaunchAgents/local.user.MouseMonitor.plist"
-- The USB vendor ID and app info.
set vendorID to "Product ID: 0xc53f"
set appName to "Mos"
set appPath to "/Applications/Mos.app"

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
    display alert "Error in Mouse Monitor script" ¬
        message errMsg & return & return & ¬
        "The LaunchAgent will now be unloaded to prevent further retries." ¬
        as warning buttons {"OK"} default button "OK"
    -- Unload the agent so launchd stops trying to rerun it.
    do shell script "launchctl unload " & quoted form of agentPlist
    return
end try
