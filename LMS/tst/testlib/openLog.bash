#
#	Use the script name to create a log name and prepend the path
#
lmstst_logName="${dirAppLog}/${lmsapp_name}.log"

#
#	Open the newly named log file
#
lmsLogOpen "${lmstst_logName}" "new"
[[ $? -eq 0 ]] ||
 {
	lmscli_optSilent=0
	lmsConioDisplay "Unable to open log file: '${lmstst_logName}'"
	exit 1
 }

