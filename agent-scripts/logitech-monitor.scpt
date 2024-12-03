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
