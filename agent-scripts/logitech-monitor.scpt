-- Description:
-- 	Check if a Logitech USB device is connected, then launch Logitech G Hub, if not already
--  running, when the device is detected.
-- Note:
--  There shouldn't be a need to change the vendorID, appName, or appPath variables.

-- Path to your LaunchAgent.
set agentPlist to (do shell script "printf %s \"$HOME\"") & "/Library/LaunchAgents/local.StrangeRanger.LogitechMonitor.plist"
-- The USB vendor ID and app info.
set vendorID to "0x046d"
set appName to "lghub"
set appPath to "/Applications/lghub.app"

try
	set usbDevices to do shell script "system_profiler SPUSBHostDataType"
    if usbDevices contains vendorID then
        if not application appName is running then
            do shell script "open " & quoted form of appPath
        end if
    end if
on error errMsg number errNum
    display alert "Error in Logitech Monitor script" ¬
        message errMsg & return & return & ¬
        "The LaunchAgent will now be unloaded to prevent further retries." ¬
        as warning buttons {"OK"} default button "OK"
    do shell script "launchctl unload " & quoted form of agentPlist
	return
end try
