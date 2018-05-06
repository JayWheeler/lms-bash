#
#	Run the startup initialize function(s)
#
lmsStartupInit $lmsscr_Version ${lmsvar_errors}
[[ $? -eq 0 ]] ||
 {
	lmsConioDebug $LINENO "Debug" "Unable to load error codes."
	exit 1
 }

#
#	Select the error codes from the XML error file
#
lmsXPathSelect "lmsErrors" ${lmserr_arrayName}
[[ $? -eq 0 ]] ||
 {
	lmsConioDebug $LINENO "XmlError" "Unable to select ${lmserr_arrayName}"
	exit 1
 }

