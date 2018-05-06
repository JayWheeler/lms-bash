#!/bin/bash
# *****************************************************************************
# *****************************************************************************
#
#   testLmsError.bash
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.1.2
# @copyright © 2016, 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package Linux Management Scripts
# @subpackage tests
#
# *****************************************************************************
#
#	Copyright © 2016, 2017. EarthWalk Software
#	Licensed under the Academic Free License, version 3.0.
#
#	Refer to the file named License.txt provided with the source,
#	or from
#
#			http://opensource.org/licenses/academic.php
#
# *****************************************************************************
#
#			Version 0.0.1 - 02-22-2016.
#					0.0.2 - 03-18-2016.
#					0.1.0 - 01-11-2017.
#					0.1.1 - 01-24-2017.
#					0.1.2 - 02-23-2017.
#
# *****************************************************************************
# *****************************************************************************

declare    lmsapp_name="testLmsError"
declare    lmslib_release="0.1.1"

# *****************************************************************************

. testlib/installDirs.bash

. $dirAppLib/stdLibs.bash
. $dirLib/lmsSortArray.bash

. $dirAppLib/cliOptions.bash
. $dirAppLib/commonVars.bash

# *****************************************************************************

lmsscr_Version="0.1.1"					# script version
declare lmstst_errorNumber=0

# *****************************************************************************
# *****************************************************************************
#
#		External Functions
#
# *****************************************************************************
# *****************************************************************************

. $dirAppLib/testDump.bash

# *****************************************************************************
# *****************************************************************************
#
#		Test Functions
#
# *****************************************************************************
# *****************************************************************************

# *****************************************************************************
# *****************************************************************************
#
#		Start main program below here
#
# *****************************************************************************
# *****************************************************************************

lmsScriptFileName $0

. $dirAppLib/openLog.bash
. $dirAppLib/startInit.bash

# *****************************************************************************
# *****************************************************************************
#
#		Run the tests starting here
#
# *****************************************************************************
# *****************************************************************************

lmsConioDisplay " "
lmstst_errorName="QueuePop"

lmsConioDisplay "lmsErrorLookupName '${lmstst_errorName}'"

lmsErrorLookupName "QueuePop"
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "lmsErrorLookupName failed for QueuePop"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

lmsConioDisplay "$lmserr_name = '$lmserr_message'"

# *****************************************************************************

lmstst_errorNumber=20

lmsConioDisplay ""
lmsConioDisplay "lmsErrorLookupNumber ${lmstst_errorNumber}"

lmsErrorLookupNumber ${lmstst_errorNumber}
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "error code lookup failed"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

lmsConioDisplay ""
lmsConioDisplay "Error number $lmserr_number = $lmserr_name"
lmsConioDisplay "    $lmserr_message"
lmsConioDisplay "-----------------------------------"

# *****************************************************************************

lmstst_errorName="DOMError"

lmsConioDisplay ""
lmsConioDisplay "validErrorName '${lmstst_errorName}'"

lmsErrorValidName ${lmstst_errorName}
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "${lmstst_errorName} not found"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

# *****************************************************************************

lmstst_errorNumber=6

lmsConioDisplay " "
lmsConioDisplay "lmsErrorValidNumber '${lmstst_errorNumber}'"

lmsErrorValidNumber ${lmstst_errorNumber}
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "Did not find Error #${lmstst_errorNumber}"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

lmsConioDisplay ""
lmsConioDisplay "Error number ${lmstst_errorNumber} is valid"
lmsConioDisplay "-----------------------------------"

# *****************************************************************************

lmsConioDisplay " "
lmsConioDisplay "lmsErrorQuery lmsUIdExists UNFORMATTED"

lmsErrorQuery "lmsUIdExists" 0
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "Did not find lmsUIdExists"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

lmsConioDisplay ""
lmsConioDisplay "Error number '${lmserr_number}' = '${lmserr_name}'"
lmsConioDisplay "    Error message='${lmserr_message}'"
lmsConioDisplay "-----------------------------------"

# *****************************************************************************

lmsConioDisplay "lmsErrorQuery lmsUIdExists FORMATTED"

lmsErrorQuery "lmsUIdExists" 1
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "Did not find lmsUIdExists"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

lmsConioDisplay ""
lmsConioDisplay "Error number $lmserr_number = $lmserr_name"
lmsConioDisplay "    Error message=$lmserr_message"
lmsConioDisplay "-----------------------------------"

# *****************************************************************************

lmsConioDisplay "lmsErrorQuery 5 DEFAULT (UNFORMATTED)"

lmsErrorQuery 5
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "Did not find Error #5"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

lmsConioDisplay ""
lmsConioDisplay "Error number $lmserr_number = $lmserr_name"
lmsConioDisplay "    Error message=$lmserr_message"
lmsConioDisplay "-----------------------------------"

# *****************************************************************************

lmsConioDisplay "lmsErrorQuery 5 FORMATTED"

lmsErrorQuery 5 1
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "Did not find lmsUIdExists"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

lmsConioDisplay ""
lmsConioDisplay "Error number $lmserr_number = $lmserr_name"
lmsConioDisplay "    Error message=$lmserr_message"
lmsConioDisplay "-----------------------------------"

# *****************************************************************************

lmsConioDisplay "lmsErrorQuery NotRoot"

lmsErrorQuery "NotRoot"
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "Did not find NotRoot"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

lmsConioDisplay ""
lmsConioDisplay "Error number $lmserr_number = $lmserr_name"
lmsConioDisplay "    Error message=$lmserr_message"
lmsConioDisplay "-----------------------------------"

# *****************************************************************************

lmsConioDisplay " "
lmsConioDisplay "lmsErrorQuery 22"

lmsErrorQuery 22
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "Did not find Error #22"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

lmsConioDisplay ""
lmsConioDisplay "Error number $lmserr_number = $lmserr_name"
lmsConioDisplay "    Error message=$lmserr_message"
lmsConioDisplay "-----------------------------------"

# *****************************************************************************

lmsConioDisplay " "

lmsConioDisplay "Error name KEYS"

lmsConioDisplay " "
lmssrt_array=()

lmsDynnReset ${lmserr_arrayName}
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "lmsDynnReset failed"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

lmsDynnReload ${lmserr_arrayName}
[[ $? -eq 0 ]] ||
 {
	lmscli_optLogDisplay=0
	lmsLogDisplay "lmsDynnReload failed"
	testDumpExit "lmscfg_x lmstest_ lmserr_ lmsxmp_"
 }

error=0
while [[ $lmsdyna_valid -eq 1 ]]
do
	lmsDynnKey "${lmserr_arrayName}" index
	[[ $? -eq 0 ]] || 
	{
		error=1
		lmsLogDisplay "lmsDynnKey failed"
		break
	}

	printf -v digits "10#%04u" $index
	lmssrt_array[${#lmssrt_array[@]}]=$digits

	lmsDynnNext ${lmserr_arrayName}
	[[ $? -eq 0 ]] ||
	 {
		error=2
		lmsLogDisplay "lmsDynnNext failed"
		break
	 }

	lmsDynn_Valid
	lmsdyna_valid=$?
done

[[ $error -eq 0 ]] &&
{
	lmsSortArrayBubble
	lmsUtilATS $lmssrt_array lmstst_buffer
	lmsConioDisplay "$lmstst_buffer"
}

# *****************************************************************************

lmscli_optDebug=0

# *****************************************************************************

lmsConioDisplay "lmsErrorCodeList NAME unformatted console"

	lmsErrorCodeList 1 0 0

# *****************************************************************************

lmsConioDisplay "lmsErrorCodeList NAME unformated BUFFER"

	lmsErrorCodeList 1 0 1
	lmsConioDisplay "$lmserr_msgBuffer"

# *****************************************************************************

lmsConioDisplay " "
lmsConioDisplay "*******************************************************"
lmsConioDisplay " "
lmsConioDisplay "NUMBER unformatted console"

	lmsErrorCodeList 0 0 0

# *****************************************************************************

lmsConioDisplay "NUMBER unformatted BUFFER"

	lmsErrorCodeList 0 0 1
	lmsConioDisplay "$lmserr_msgBuffer"

# *****************************************************************************

lmsConioDisplay "NUMBER FORMATTED console"

	lmsErrorCodeList 0 1 0

# *****************************************************************************

lmsConioDisplay "lmsErrorCodeList NUMBER FORMATTED BUFFER"

	lmsErrorCodeList 0 1 1
	lmsConioDisplay "$lmserr_msgBuffer"

# *****************************************************************************

lmsConioDisplay " "
lmsConioDisplay "*******************************************************"
lmsConioDisplay " "

lmsConioDisplay "lmsErrorCodeList NAME FORMATTED console"

	lmsErrorCodeList 1 1 0

# *****************************************************************************

lmsConioDisplay "lmsErrorCodeList NAME FORMATTED BUFFER"

	lmsErrorCodeList 1 1 1
	lmsConioDisplay "$lmserr_msgBuffer"

# *****************************************************************************

. $dirAppLib/scriptEnd.bash

# *****************************************************************************
