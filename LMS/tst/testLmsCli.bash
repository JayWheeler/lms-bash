#!/bin/bash
# ***************************************************************************************************
# ***************************************************************************************************
#
#   testLmsCli.bash
#
# ***************************************************************************************************
#
# @author Jay Wheeler.
# @version 0.1.3
# @copyright © 2016, 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package Linux Management Scripts
# @subpackage tests
#
# ***************************************************************************************************
#
#	Copyright © 2016, 2017. EarthWalk Software
#	Licensed under the Academic Free License, version 3.0.
#
#	Refer to the file named License.txt provided with the source,
#	or from
#
#			http://opensource.org/licenses/academic.php
#
# ***************************************************************************************************
#
#			Version 0.0.1 - 02-24-2016.
#					0.0.2 - 07-01-2016.
#					0.1.0 - 01-17-2017.
#					0.1.1 - 01-23-2017.
#					0.1.2 - 02-11-2017.
#					0.1.3 - 02-23-2017.
#
# ***************************************************************************************************
# ***************************************************************************************************

declare    lmsapp_name="testLmsCli"
declare    lmslib_release="0.1.1"

# *****************************************************************************

. testlib/installDirs.bash

. $dirAppLib/stdLibs.bash

. $dirAppLib/cliOptions.bash
. $dirAppLib/commonVars.bash

# *****************************************************************************

declare    lmsscr_Version="0.1.3"	# script version

declare    lmstst_Declarations="$dirEtc/testVariables.xml"

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

lmscli_optDebug=0
lmscli_optQueueErrors=0
lmscli_Errors=0

lmscli_optLogDisplay=1

lmsConioDisplay "Loading cli parameters from ${lmstst_Declarations}"

# *****************************************************************************

lmsDomCLoad ${lmstst_Declarations} "lmstst_stack" 0
[[ $? -eq 0 ]] ||
 {
	lmsConioDisplay "DomError - lmsDomCLoad failed."
	testDumpExit "lmsdom_ lmstst_ lmsstk lmscli"
 }

# *****************************************************************************


lmsCliParse
[[ $? -eq 0 ]] || lmsConioDisplay "cliParameterParse failed"

[[ ${lmscli_Errors} -eq 0 ]] ||
 {
	lmsCli_optDebug=1
	lmsConioDebugL "CliError" "cliErrors = ${lmscli_Errors}, param = ${lmscli_paramErrors}, cmnd = ${lmscli_cmndErrors}"
	lmsCli_optDebug=0
 }

[[ ${lmscli_Errors} -eq 0 ]] &&
 {
	lmsCliApply
	[[ $? -eq 0 ]] || lmsConioDisplay "lmsCliApply failed."
 }


lmstst_buffer=""

lmsConioDisplay ""
lmsUtilATS "lmscli_shellParam" lmstst_buffer
lmsConioDisplay "$lmstst_buffer"

lmsConioDisplay ""
lmsUtilATS "lmscli_InputParam" lmstst_buffer
lmsConioDisplay "$lmstst_buffer"

lmsConioDisplay ""
testLmsDmpVar "lmscli_"
lmsConioDisplay ""

# *****************************************************************************

. $dirAppLib/scriptEnd.bash

# *****************************************************************************
