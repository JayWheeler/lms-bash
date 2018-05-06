#
#	Load the error codes from the XML error file
#			Version 0.0.1 - 01-23-2017.
#

lmsXPathSelect ${lmserr_arrayName}
[[ $? -eq 0 ]] ||
 {
	lmsConioDebug $LINENO "XmlError" "Unable to select ${lmserr_arrayName}"
	exit 1
 }

