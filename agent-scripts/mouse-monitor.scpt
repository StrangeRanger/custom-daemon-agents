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

set vendorID to "Product ID: 0xc53f"
set appName to "Mos"
set appPath to "/Applications/Mos.app"

-- Get a list of connected USB devices.
try
	set usbDevices to do shell script "system_profiler SPUSBDataType"
on error errMsg
	display dialog "Error fetching USB devices: " & errMsg buttons {"OK"} default button "OK"
	return
end try

-- Check if the vendor ID is present in the list.
if usbDevices contains vendorID then
	-- Launch the application if it is not already running.
	if not application appName is running then
		do shell script "open " & quoted form of appPath
	end if
end if
