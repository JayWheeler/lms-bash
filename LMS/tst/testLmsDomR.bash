#!/bin/bash
# *****************************************************************************
# *****************************************************************************
#
#	testLmsDomR.bash
#
#		Test the DOMDocument, lmsDomRRead, DOMNode and lmsDomToStr libraries.
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.1.3
# @copyright © 2016, 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package Linux Management Scripts
# @subpackage DOM
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
#			Version 0.0.1 - 07-22-2016.
#					0.0.2 - 09-05-2016.
#					0.1.0 - 01-15-2017.
#					0.1.1 - 01-23-2017.
#					0.1.2 - 02-10-2017.
#					0.1.3 - 02-23-2017.
#
# *****************************************************************************
# *****************************************************************************

declare    lmsapp_name="testLmsDomR"
declare    lmslib_release="0.1.1"

# *****************************************************************************

. testlib/installDirs.bash

. $dirAppLib/stdLibs.bash
. $dirLib/lmsDomTS.bash

. $dirAppLib/cliOptions.bash
. $dirAppLib/commonVars.bash

# *****************************************************************************

lmsscr_Version="0.1.3"						# script version

#lmstst_testOptions="$dirEtc/errorCodes.xml"
#lmstst_testOptions="$dirEtc/testDeclarations.xml"
#lmstst_testOptions="$dirEtc/testDOMVariables.xml"
lmstst_testOptions="$dirEtc/cliOptions.xml"

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
#		Run the lmsDomRRead tests
#
# *****************************************************************************
# *****************************************************************************

lmscli_optLogDisplay=0

lmsDomRInit
[[ $? -eq 0 ]] ||
 {
	lmsConioDebug $LINENO "DomError" "lmsDomRInit failed."
	exit 1
 }

lmsConioDisplay "********************************"
lmsConioDisplay
lmsConioDisplay " Processing XML file '${lmstst_testOptions}' into the document tree."
lmsConioDisplay

lmsDomDParse ${lmstst_testOptions}
[[ $? -eq 0 ]] || lmsConioDebugExit $LINENO "DomError" "lmsDomDParse '${lmstst_Declarations}'"

lmsConioDisplay "********************************"
lmsConioDisplay
lmsConioDisplay " Creating output buffer from the document tree."
lmsConioDisplay

lmsDomToStr lmstst_buffer
[[ $? -eq 0 ]] || lmsConioDebugExit $LINENO "DomError" "lmsDomToStr failed, buffer = '$lmstst_buffer'"

lmsConioDisplay "********************************"
lmsConioDisplay
lmsConioDisplay " Document tree:"
lmsConioDisplay
lmsConioDisplay "---------------------------------"
lmsConioDisplay "$lmstst_buffer"
lmsConioDisplay "---------------------------------"
lmsConioDisplay

# *****************************************************************************

. $dirAppLib/scriptEnd.bash

# *****************************************************************************
