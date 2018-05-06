#!/bin/bash
# *****************************************************************************
# *****************************************************************************
#
#   testLmsColorDef.bash
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.0.2
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
#			Version 0.0.1 - 06-19-2016.
#					0.0.2 - 02-09-2017.
#
# *****************************************************************************
# *****************************************************************************

testlibDir="../../testlib"

. $testlibDir/installDirs.bash
. $testlibDir/stdLibs.bash
. $testlibDir/cliOptions.bash

. $testlibDir/commonVars.bash

# *****************************************************************************

lmsscr_Version="0.0.2"					# script version

# *****************************************************************************
# *****************************************************************************
#
#		External Functions
#
# *****************************************************************************
# *****************************************************************************

. $testlibDir/testDump.bash
. $testlibDir/testUtilities.bash

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

. $testlibDir/openLog.bash
. $testlibDir/startInit.bash

# *****************************************************************************
# *****************************************************************************
#
#		Run the tests starting here
#
# *****************************************************************************
# *****************************************************************************

lmsConioDisplay "${lmsclr_Red}RED${lmsclr_NoColor}"
lmsConioDisplay "${lmsclr_Bold}${lmsclr_Red}BOLD RED${lmsclr_NoColor}"
lmsConioDisplay ""

lmsConioDisplay "${lmsclr_Purple}PURPLE${lmsclr_NoColor}"
lmsConioDisplay "${lmsclr_Bold}${lmsclr_Purple}BOLD PURPLE${lmsclr_NoColor}"
lmsConioDisplay ""

lmsConioDisplay "${lmsclr_Blue}BLUE${lmsclr_NoColor}"
lmsConioDisplay "${lmsclr_Bold}${lmsclr_Blue}BOLD BLUE${lmsclr_NoColor}"
lmsConioDisplay ""

lmsConioDisplay "no color"

# *****************************************************************************

. $testlibDir/testEnd.bash

# *****************************************************************************
