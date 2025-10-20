-- Description:
-- 	Check if a specific USB device is connected, then launch LinearMouse, if not already
--  running, when device is detected.
-- Note:
--  The product ID is specific to my mouse. If you want to use this script, you'll need to
--  replace the product ID with the one for your mouse.

-- Path to your LaunchAgent.
set agentPlist to POSIX path of (path to home folder) & "Library/LaunchAgents/local.StrangeRanger.MouseMonitor.plist"
-- The USB vendor ID and app info.
set vendorID to "Product ID: 0xc53f"
set appName to "LinearMouse"
set appPath to "/Applications/LinearMouse.app"

try
	set usbDevices to do shell script "system_profiler SPUSBHostDataType"
    if usbDevices contains vendorID then
        if not application appName is running then
            do shell script "open " & quoted form of appPath
        end if
    end if
on error errMsg number errNum
    display alert "Error in Mouse Monitor script" ¬
        message errMsg & return & return & ¬
        "The LaunchAgent will now be unloaded to prevent further retries." ¬
        as warning buttons {"OK"} default button "OK"
    do shell script "launchctl unload " & quoted form of agentPlist
    return
end try

