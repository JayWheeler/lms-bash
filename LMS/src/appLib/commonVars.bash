#
# script version - s/b replace in script with actual version
#
lmsscr_Version="0.0.1"						# script version

#
# test files
#
lmsvar_errors="$dirEtc/errorCodes.xml"
lmsvar_help="$dirEtc/testHelp.xml"			# path to the help information file

#
# default application vars
#
lmsapp_guid=""
lmsapp_nsuid=""

lmsapp_logDir="${dirAppLog}"
lmsapp_logName="${dirAppLog}/${lmsapp_name}"

lmsapp_result=0

lmsapp_stackSize=0
lmsapp_stackCurrent=0
lmsapp_stackName="lmsapp_stack"

lmsapp_buffer=""
lmsapp_helpBuffer=""

lmsapp_item=""

lmsapp_abort=0								# abort flag: set to 1 to abort the application script
