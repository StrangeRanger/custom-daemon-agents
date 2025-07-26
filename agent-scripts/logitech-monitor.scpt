-- Description:
-- 	Check if a Logitech USB device, then launch the Logitech G Hub application if the
--  device is connected and the app is not already running.
-- Purpose:
--  Logitech G Hub is used to configure Logitech gaming peripherals. I only want the
--  application to run when I'm using my Logitech devices, so I use this script + an
--  agent to launch the application when the mouse is connected.

-- There shouldn't be a need to change the vendorID, appName, or appPath variables.
set vendorID to "0x046d"
set appName to "lghub"
set appPath to "/Applications/lghub.app"

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
