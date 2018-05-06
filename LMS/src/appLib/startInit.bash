#
#	Run the startup initialize function(s)
#
lmsStartupInit $lmsscr_Version ${lmsvar_errors}
[[ $? -eq 0 ]] ||
 {
	lmsConioDebugL "Debug" "Unable to load error codes."
	exit 1
 }

#
#	Select the error codes from the XML error file
#
lmsXPathSelect "lmsErrors" ${lmserr_arrayName}
[[ $? -eq 0 ]] ||
 {
	lmsConioDebugL "XmlError" "Unable to select ${lmserr_arrayName}"
	lmsErrorExitScript "XmlError"
 }

#lmsHelpInit ${lmsvar_help}
#[[ $? -eq 0 ]] ||
# {
#	lmsConioDebugL "HelpError" "Help init failed."
#	lmsErrorExitScript "HelpError"
# }

lmsDomCLoad "${lmsapp_declare}" "${lmsapp_stackName}" 0
[[ $? -eq 0 ]] ||
 {
	lmsapp_result=$?
	lmsConioDebugL "DOMError" "Startup failed in lmsDomCLoad error: ${lmsapp_result}"
	lmsErrorExitScript "DOMError"
 }

lmsCliParse
[[ $? -eq 0 ]] || 
{
	lmsConioDebugL "CliError" "cliParameterParse failed"
	lmsErrorExitScript "CliError"
}

[[ ${lmscli_Errors} -eq 0 ]] ||
 {
	lmsConioDebugL "CliError" "cliErrors = ${lmscli_Errors}, param = ${lmscli_paramErrors}, cmnd = ${lmscli_cmndErrors}"
	lmsErrorExitScript "CliError"
 }

lmsCliApply
[[ $? -eq 0 ]] || 
 {
	lmsConioDebugL "CliError" "lmsCliApply failed: $?"
	lmsErrorExitScript "CliError"
 }



