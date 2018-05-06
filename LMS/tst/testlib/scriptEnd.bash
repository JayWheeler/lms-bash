
[[ ${lmscli_optDebug} -eq 0  &&  ${lmscli_optQueueErrors} -ne 0 ]]  &&  lmsErrorQDispPop
[[ ${lmscli_optDevelopment} -eq 1 ]] && logName=${dirAppLog} || logName=${dirTestLog}

lmsConioDisplay ""
lmsConioDisplay "$(tput bold) Log-file: '${lmstst_logName}' $(tput sgr0)"

[[ ${lmscli_optDevelopment} -eq 0 ]] && lmsErrorExitScript "None"  || lmsErrorExitScript "EndOfTest"

