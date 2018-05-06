#!/bin/bash
# *****************************************************************************
# *****************************************************************************
#
#	testLmsConio.bash
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.0.2
# @copyright © 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package Linux Management Scripts
# @subpackage tests
#
# *****************************************************************************
#
#	Copyright © 2017. EarthWalk Software
#	Licensed under the Academic Free License, version 3.0.
#
#	Refer to the file named License.txt provided with the source,
#	or from
#			http://opensource.org/licenses/academic.php
#
# *****************************************************************************
#
#			Version 0.0.1 - 01-29-2017.
#					0.0.2 - 02-23-2017.
#
# *****************************************************************************
# *****************************************************************************

declare    lmsapp_name="testLmsConio"
declare    lmslib_release="0.1.1"

# *****************************************************************************

. testlib/installDirs.bash

. $dirAppLib/stdLibs.bash

. $dirAppLib/cliOptions.bash
. $dirAppLib/commonVars.bash

# *****************************************************************************

lmsscr_Version="0.0.2"						# script version

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

# *********************************************************************************
#
#    testLmsConioDisplay
#
#      print message, if allowed
#
#	parameters:
#		message = a string to be printed
#		noEnter = if present, no end-of-line will be output
#
# *********************************************************************************
function testLmsConioDisplay()
{
	local message="${1}"
	
	echo "testLmsConioDisplay '${message}'"
	echo "----------------"

	lmsConioDisplay "${message}" ${2}
	[[ $? -eq 0 ]] ||
	{
		lmstst_result=$?
		return 1
	}

	return 0
}

# **************************************************************************
#
#    testLmsConioDebug
#
#      print debug message, if allowed
#
#	parameters:
#		lineNo = line number
#		errorCode = error code
#		modifier = additional information to supplement the error message
#
#	Returns
#		0 = no error
#		1 = error
#
# **************************************************************************
function testLmsConioDebug()
{
	local errorLine="${1}"
	local errorCode="${2}"
	local errorMod="${3}"

	echo "testLmsConioDebug: '${errorLine}' '${errorCode}' '${errorMod}'"
	echo "--------------"

	lmstst_result=0
	lmsConioDebug "${errorLine}" "${errorCode}" "${errorMod}"
	[[ $? -eq 0 ]] || 
	{
		lmstst_result=$?
		return 1
	}

	return 0
}

# **************************************************************************
#
#    testLmsConioDebugExit
#
#      print debug message, if allowed
#
#	parameters:
#		lineNo = line number
#		errorCode = error code
#		modifier = additional information to supplement the error message
#		lmsDmpVar = non-zero to print ALL bash variables and their values
#
#	Returns:
#		DOES NOT RETURN
#
# **************************************************************************
function testLmsConioDebugExit()
{
	local errorLine={$1}
	local errorCode=${2}
	local errorMod="${3}"
	local errorDump=${4:-0}
	
	echo "testLmsConioDebugExit: '${errorLine}' '${errorCode}' '${errorMod}' '${errorDump}'"
	echo "------------------"

	lmstst_result=0
	lmsConioDebugExit ${errorLine} ${errorCode} "${errorMod}"
}

# **************************************************************************
#
#    testLmsConioDisplayTrimmed
#
#		lmsStrTrim leading and trailing blanks and display
#
#	parameters:
#		string = the string to lmsStrTrim
#		name = the display name of the string
#	returns:
#		places the result in the global variable: lmsstr_Trimmed
#
# **************************************************************************
function testLmsConioDisplayTrimmed()
{
	echo "testLmsConioDisplayTrimmed: '${1}' '${2}'"
	echo "-----------------------"

	lmstst_result=0
	lmsConioDisplayTrimmed "${1}" "${2}"
	[[ $? -eq 0 ]] ||
	{
		lmstst_result=$?
		return 1
	}

	return 0
}

# **************************************************************************
#
#    testLmsConioPrompt
#
#		Output a prompt for input and return it
#
#	parameters:
#		prompt = the message to print
#		noEcho = do not echo the input as it is typed
#
#	returns:
#		0 = no error
#		non-zero = error number
#
# **************************************************************************
function testLmsConioPrompt()
{
	echo "testLmsConioPrompt: '${1}' '${2}'"
	echo "---------------"

	lmsConioPrompt "${1}" ${2}
	[[ $? -eq 0 ]] ||
	{
		lmstst_error=$?
		return 1
	}

	echo "Input: '${REPLY}'"
	return 0
}

# **************************************************************************
#
#    testLmsConioPromptReply
#
#		Output a prompt for input and return in specified global variable
#
#	parameters:
#		prompt = the message to print
#		reply = the input from the console
#		noEcho = do not echo the input as it is typed
#
#	returns:
#		0 = no error
#		non-zero = error number
#
# **************************************************************************
function testLmsConioPromptReply()
{
	echo "testLmsConioPromptReply: '${1}' '${2}'"
	echo "--------------------"

	lmsConioPromptReply "${1}" lmstst_reply ${2}
	[[ $? -eq 0 ]] ||
	 {
		lmstst_error=$?
		return 1
	 }

	echo "Reply: '${lmstst_reply}'"

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

lmscli_optSilent=1

testLmsConioDisplay "Starting conio tests. - only happens when not silent"
echo ""

# *****************************************************************************

lmscli_optSilent=0

testLmsConioDisplay "Starting conio tests. - only happens when not silent"
echo ""

# *****************************************************************************

testLmsConioDebug $LINENO "Debug" "Debug output test - only happens when debug option set"
echo ""

# *****************************************************************************

lmscli_optDebug=1

testLmsConioDebug $LINENO "Debug" "Debug output test - only happens when debug option set"
echo ""

# *****************************************************************************

testLmsConioDisplayTrimmed "         string to     be    trimmed       " "TestString" 
echo ""

# *****************************************************************************

testLmsConioPrompt "Enter a resonse to display"
echo ""

# *****************************************************************************

testLmsConioPromptReply "Enter a resonse to display"
echo ""

# *****************************************************************************

. $dirAppLib/scriptEnd.bash

# *****************************************************************************
