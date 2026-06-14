-- Description:
--  Check if any connected HID mouse is connected, then launch LinearMouse, if not already
--  running, when a mouse is detected.
-- Note:
--  This checks the HID usage values for a mouse instead of matching a specific vendor or
--  product ID, so it works across mouse manufacturers.
--  Built-in pointing devices are ignored so this only reacts to a connected external mouse.

-- Path to your LaunchAgent.
set agentPlist to (do shell script "printf %s \"$HOME\"") & "/Library/LaunchAgents/local.StrangeRanger.MouseMonitor.plist"
-- The shell command and app info.
set mouseDetectionCommand to "hidutil list | awk 'NR > 2 && $4 == 1 && $5 == 2 && $NF == 0 { found=1 } END { print found ? \"1\" : \"0\" }'"
set appName to "LinearMouse"
set appPath to "/Applications/LinearMouse.app"

try
    set mouseConnected to do shell script mouseDetectionCommand
    if mouseConnected is "1" then
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
