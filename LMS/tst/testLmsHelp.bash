#!/bin/bash
# *****************************************************************************
# *****************************************************************************
#
#   testHelpFunctions.bash
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.1.1
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
#		Version 0.0.1 - 06-09-2016.
#				0.0.2 - 01.09-2017.
#				0.1.0 - 01-29-2017.
#				0.1.1 - 02-23-2017.
#
# *****************************************************************************
# *****************************************************************************

declare    lmsapp_name="testLmsHelp"
declare    lmslib_release="0.1.1"

# *****************************************************************************

. testlib/installDirs.bash

. $dirAppLib/stdLibs.bash

. $dirAppLib/cliOptions.bash
. $dirAppLib/commonVars.bash

# *****************************************************************************

lmsscr_Version="0.1.1"				# script version

#lmsvar_help="$dirEtc/helpTest.xml"	# path to the help file
lmsvar_help="$dirEtc/lmsInstallHelp.xml"	# path to the help file

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

function testLmsHelpInit()
{
	lmsConioDisplay ""
	lmsConioDisplay "lmsHelpInit '${1}'"
	lmsConioDisplay ""
	
	lmsHelpInit "${1}"
	[[ $? -eq 0 ]] ||
	{
        xError=$?
		lmsConioDisplay "lmsHelp initialize failed: error = $xError, result = $lmshlp_error"
		testDumpExit "lmshlp_"
	}
	
	return 0
}

function testLmsHelpToStrV()
{
	lmsConioDisplay ""
	lmsConioDisplay "lmsHelpToStrV"

	lmstst_buffer=""
	lmsHelpToStrV lmstst_buffer
	[[ $? -eq 0 ]] ||
	{
		lmsConioDisplay "lmsHelpToStrV failed: $?, result = $lmshlp_error"
		testDumpExit "lmshlp_"
	}

	lmsConioDisplay "'${lmstst_buffer}'"
	return 0
}

function testLmsHelpToStr()
{
	lmsConioDisplay ""
	lmsConioDisplay "lmsHelpToStr"

	lmstst_buffer=$( lmsHelpToStr lmstst_buffer )
	[[ $? -eq 0 ]] ||
	{
		lmsConioDisplay "lmsHelpToStr failed: $?, result = $lmshlp_error"
		testDumpExit "lmshlp_"
	}

	lmsConioDisplay "'${lmstst_buffer}'"
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

lmscli_optDebug=0

testLmsHelpInit "${lmsvar_help}"

testLmsHelpToStr

lmsConioDisplay "================================="

testLmsHelpToStrV

# *****************************************************************************

. $dirAppLib/scriptEnd.bash

# *****************************************************************************
