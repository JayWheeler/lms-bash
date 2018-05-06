#!/bin/bash
# *****************************************************************************
# *****************************************************************************
#
#   testLmsErrorQ.bash
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.1.3
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
#			Version 0.0.1 - 03-25-2016.
#					0.1.0 - 01-12-2017.
#					0.1.1 - 01-24-2017.
#					0.1.2 - 02-09-2017.
#					0.1.3 - 02-23-2017.
#
# *****************************************************************************
# *****************************************************************************

declare    lmsapp_name="testLmsErrorQ"
declare    lmslib_release="0.1.1"

# *****************************************************************************

. testlib/installDirs.bash

. $dirAppLib/stdLibs.bash

. $dirAppLib/cliOptions.bash
. $dirAppLib/commonVars.bash

# *****************************************************************************

lmsscr_Version="0.1.3"					# script version

declare    lmstst_stackName="errorQueueStack"

# *****************************************************************************
# *****************************************************************************
#
#		External Functions
#
# *****************************************************************************
# *****************************************************************************

. $dirAppLib/testDump.bash
. $dirAppLib/testUtilities.bash

# *****************************************************************************
# *****************************************************************************
#
#		Test Functions
#
# *****************************************************************************
# *****************************************************************************

# *****************************************************************************
#
#	testLmsErrorQInit
#
#		Test the lmsStackCreate functionality
#
#	parameters:
#		qName = the name of the queue to create
#
#	Returns
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function testLmsErrorQInit()
{
	local qName="${1}"
	
	lmsConioDisplay
	lmsConioDisplay "testLmsErrorQInit '${qName}'"

	lmsErrorQInit "${qName}"
	[[ $? -eq 0 ]] ||
	 {
		lmstst_result=$?
		lmsConioDisplay "Unable to create a queue named '${qName}', result = $lmstst_result"
		return 1
	 }

	lmstst_stackName=$qName

	testHighlightMessage "name = '${lmstst_stackName}'"
	return 0
}

# *****************************************************************************
#
#	testLmsErrorQWrite
#
#		Test the lmsErrorQWrite functionality
#
#	parameters:
#		qName = the name of the queue to create
#		lineNo = line number
#		errorCode = error code
#		modifier = additional information to supplement the error message
#
#	Returns
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function testLmsErrorQWrite()
{
	local qName="${1}"
	
	local qLine=${2:-"0"}
	local qCode=${3:-"0"}
	local qMod=${4:-""}
	
	lmsConioDisplay
	lmsConioDisplay "testLmsErrorQWrite '${qName}' = '${qLine}' '${qCode}' '${qMod}'"

	lmsErrorQWrite ${qName} "${qLine}" "${qCode}" "${qMod}"
	[[ $? -eq 0 ]] ||
	 {
		lmstst_result=$?
		lmsConioDisplay "Unable to write to the queue named '${qName}', result = $lmstst_result"
		return 1
	 }

	testHighlightMessage "'${qName}' was successful." 1
	return 0
}

# *****************************************************************************
#
#	testLmsErrorQWriteX
#
#		Test the lmsErrorQWriteX functionality
#
#	parameters:
#		qName = the name of the queue to create
#		lineNo = line number
#		errorCode = error code
#		modifier = additional information to supplement the error message
#
#	Returns
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function testLmsErrorQWriteX()
{
	local qName="${1}"
	
	local qLine=${2:-"0"}
	local qCode=${3:-"0"}
	local qMod=${4:-""}
	
	lmsConioDisplay "testLmsErrorQWriteX '${qName}' = '${qLine}' '${qCode}' '${qMod}'"

	lmsErrorQWriteX $qName "${qLine}" "${qCode}" "${qMod}"
	[[ $? -eq 0 ]] ||
	 {
		lmstst_result=$?
		lmsConioDisplay "Unable to write to the queue named '${qName}', result = $lmstst_result"
		return 1
	 }

	testHighlightMessage "'${qName}' was successful." 1
	return 0
}

# *****************************************************************************
#
#	testLmsErrorQRead
#
#		Test the lmsErrorQRead functionality
#
#	parameters:
#		qName = the name of the queue to read
#		qData = location to place the read data
#
#	Returns
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function testLmsErrorQRead()
{
	local qName="${1}"
	
	lmsConioDisplay
	lmsConioDisplay "testLmsErrorQRead '${qName}'"

	lmsErrorQRead "${qName}" lmstst_buffer
	[[ $? -eq 0 ]] ||
	 {
		lmstst_result=$?
		lmsConioDisplay "Unable to read from the queue named '${qName}', result = $lmstst_result"
		return 1
	 }

	testHighlightMessage "'${qName}' = '${lmstst_buffer}'" 1
	return 0
}

# *****************************************************************************
#
#	testLmsErrorQErrors
#
#		Test the lmsErrorQErrors functionality
#
#	parameters:
#		qName = the name of the queue to create
#
#	Returns
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function testLmsErrorQErrors()
{
	local qName="${1}"
	
	lmsConioDisplay
	lmsConioDisplay "testLmsErrorQErrors '${qName}'"

	lmsErrorQErrors $qName lmstst_stackSize
	[[ $? -eq 0 ]] ||
	 {
		lmstst_result=$?
		lmsConioDisplay "Unable to get the count of errors in the queue named '${qName}', result = $lmstst_result"
		return 1
	 }

	testHighlightMessage "'${qName}' = '${lmstst_stackSize}'" 1
	return 0
}

# *****************************************************************************
#
#	testLmsErrorQPeek
#
#		Test the lmsErrorQPeek functionality
#
#	parameters:
#		qName = the name of the queue to create
#
#	Returns
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function testLmsErrorQPeek()
{
	local qName="${1}"
	
	lmsConioDisplay
	lmsConioDisplay "testLmsErrorQPeek '${qName}'"

	lmsErrorQPeek $qName lmstst_buffer
	[[ $? -eq 0 ]] ||
	 {
		lmstst_result=$?
		lmsConioDisplay "Unable to peek at the queue named '${qName}', result = $lmstst_result"
		return 1
	 }

	testHighlightMessage "'${qName}' = '${lmstst_buffer}'" 1
	return 0
}

# *****************************************************************************
#
#	testLmsErrorQParse
#
#		Test the lmsErrorQParse functionality
#
#	Parameters:
#		qName = name of the error queue
#		qData = data to be parsed
#		qBuffer = queue return buffer
#		qSep = (optional) field separator, default = " "
#
#	Returns:
#		0 = no error, data returned in buffer and errQVar variables
#		1 = no error queue exists
#		2 = queue is empty
#
# *****************************************************************************
testLmsErrorQParse()
{
	local qName="${1}"
	local qData="${2}"
	local qSep=${4}
	
	lmsConioDisplay
	lmsConioDisplay "testLmsErrorQRead '${qName}'"

	lmsErrorQParse "${qName}" "${qData}" ${3} "${qSep}"
	[[ $? -eq 0 ]] ||
	 {
		lmstst_result=$?
		lmsConioDisplay "Parse queue message faile for the queue named '${qName}', result = $lmstst_result"
		return 1
	 }

	return 0
}

# *****************************************************************************
#
#	testLmsErrorQGetError
#
#		Test the lmsErrorQGetError functionality
#
#	Parameters:
#		qName = name of the error queue
#		message = location to store the printable message
#
#	Returns:
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function testLmsErrorQGetError()
{
	[[ -z "${1}" || -z "${2}" ]] && return 1

	
	return 1
}

# *****************************************************************************
#
#	testLmsErrorQResetV
#
#		Test the lmsErrorQResetV functionality
#
#	Parameters:
#		qName = the name of the error queue
#
#	Returns:
#		0 = no error
#
# *****************************************************************************
function testLmsErrorQResetV()
{
	[[ -z "${1}" ]] && return 1
	local qName="${1}"
	
	lmsConioDisplay
	lmsConioDisplay "testLmsErrorQResetV '${qName}'"

	lmsErrorQResetV "${qName}"
	[[ $? -eq 0 ]] ||
	 {
		lmstst_result=$?
		lmsConioDisplay "Unable to reset the error queue variables, result = $lmstst_result"
		return 1
	 }

	testHighlightMessage "'${qName}' was successful" 1
	return 0
}

# *****************************************************************************
#
#	testLmsErrorQExists
#
#		Test the lmsErrorQExists functionality
#
#	Parameters:
#		qName = the name of the error queue
#
#	Returns:
#		0 = exists
#		non-zero = doesn't exist
#
# *****************************************************************************
function testLmsErrorQExists()
{
	[[ -z "${1}" ]] && return 1
	local qName="${1}"
	
	lmsConioDisplay
	lmsConioDisplay "testLmsErrorQExists '${qName}'"

	lmsErrorQExists "${qName}"
	[[ $? -eq 0 ]] ||
	 {
		lmstst_result=$?
		lmsConioDisplay "Did not find the queue named '${qName}', result = $lmstst_result"
		return 1
	 }

	testHighlightMessage "'${qName}' was successful" 1
	return 0
}

# *****************************************************************************
#
#	testLmsErrorQReset
#
#		Test the lmsErrorQReset functionality
#
#	Parameters:
#		qName = the name of the error queue
#
#	Returns:
#		0 = no error
#
# *****************************************************************************
function testLmsErrorQReset()
{
	[[ -z "${1}" ]] && return 1
	local qName=${1}
	
	lmsConioDisplay
	lmsConioDisplay "testLmsErrorQReset '${qName}'"

	lmsErrorQReset ${1}
	return 0
}

# *****************************************************************************
#
#	testlmsErrorQDispPeek
#
#		Test the lmsErrorQDispPeek functionality
#
#	parameters:
#		qName = the name of the queue to display
#		qDetail = amount of detail (0 or 1)
#
#	Returns
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function testlmsErrorQDispPeek()
{
	lmsConioDisplay
	lmsConioDisplay "testlmsErrorQDispPeek '${1}' '${2}'"

	local qName="${1}"
	local qDetail=${2:-"1"}

	lmsErrorQDispPeek "${qName}" ${qDetail}
	[[ $? -eq 0 ]] ||
	 {
		lmstst_result=$?
		lmsConioDisplay "testErrQDisplay qName = '${lmserr_QName}'"
		return 1
	 }

	lmsConioDisplay ""
	return 0
}

# *****************************************************************************
#
#	testlmsErrorQDispPop
#
#		Test the lmsErrorQDispPop functionality
#
#	parameters:
#		qName = the name of the queue to display
#		qDetail = amount of detail (0 or 1)
#
#	Returns
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function testlmsErrorQDispPop()
{
	lmsConioDisplay
	lmsConioDisplay "testlmsErrorQDispPop '${1}' '${2}'"

	local qName="${1}"
	local qDetail=${2:-"1"}

	lmsErrorQDispPop "${qName}" ${qDetail}

	lmsConioDisplay ""
	return 0
}

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

lmscli_optQueueErrors=0
lmscli_optLogDisplay=0
lmscli_optDebug=0
lmscli_optSilent=0
lmscli_optQuiet=0

lmsConioDisplay "*******************************************************"

testLmsErrorQInit $lmserr_QName
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Unable to initialize error queue. (${lmstst_result})"
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testLmsErrorQErrors $lmserr_QName
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Unable to get error queue size."
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testLmsErrorQWrite $lmserr_QName $LINENO 'Debug' "QMessage 0"
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Unable to write to error queue."
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testLmsErrorQWrite $lmserr_QName $LINENO 'Debug' "QMessage 1"
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Unable to write to error queue."
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testLmsErrorQPeek $lmserr_QName lmstst_data 0
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Unable to peek."
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testLmsErrorQErrors $lmserr_QName
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Unable to get error queue size."
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "Error STACK contains $lmstst_stackSize elements"

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testlmsErrorQDispPeek $lmserr_QName 0
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Unable to get error queue size."
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testlmsErrorQDispPeek $lmserr_QName 1
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Unable to get error queue size."
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testLmsErrorQRead $lmserr_QName
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Cannot read error stack - invalid error queue"
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testLmsErrorQErrors $lmserr_QName
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Cannot get error count - invalid error queue"
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay "Error QUEUE contains $lmstst_stackSize elements"
lmsConioDisplay ""

lmsConioDisplay "*******************************************************"
lmsConioDisplay ""

testlmsErrorQDispPop $lmserr_QName 0
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Peek error."
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testLmsErrorQErrors $lmserr_QName
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Cannot get error count - invalid error queue"
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay "Error QUEUE contains $lmstst_stackSize elements"
lmsConioDisplay ""

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testLmsErrorQReset $lmserr_QName
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Queue reset failed."
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

testLmsErrorQErrors  $lmserr_QName
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "Cannot get error count - invalid error queue"
	testDumpExit "${lmserr_QName} lmserr_ lmsstk"
 }

lmsConioDisplay "Error QUEUE contains $lmstst_stackSize elements"

lmsConioDisplay ""
lmsConioDisplay "*******************************************************"

# *****************************************************************************

. $dirAppLib/scriptEnd.bash

# *****************************************************************************


