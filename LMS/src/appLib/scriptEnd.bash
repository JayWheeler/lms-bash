
[[ ${lmscli_optDebug} -eq 0  &&  ${lmscli_optQueueErrors} -ne 0 ]]  &&  lmsErrorQDispPop
#[[ ${lmscli_optProduction} -eq 1 ]] && logName=${dirAppLog} || logName=${dirTestLog}

lmsConioDisplay ""
lmsConioDisplay "$(tput bold) Log-file: '${lmsapp_logName}' $(tput sgr0)"

[[ ${lmscli_optProduction} -eq 1 ]] && lmsErrorExitScript "None"  || lmsErrorExitScript "EndOfTest"

