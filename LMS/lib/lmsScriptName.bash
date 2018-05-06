# *****************************************************************************
# *****************************************************************************
#
#   lmsScriptName.bash
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.1.1
# @copyright © 2016, 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package Linux Management Scripts
# @subpackage scriptName
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
#
#			Version 0.0.1 - 02-24-2016.
#			        0.0.2 - 03-18-2016.
#					0.1.0 - 01-24-2017.
#					0.1.1 - 02-09-2017.
#
# *****************************************************************************
# *****************************************************************************

declare -r lmslib_lmsScriptName="0.1.1"	# version of lmsscr_Name library

declare lmsscr_Directory=""			# script directory
declare lmsscr_Path=""				# script path
declare lmsscr_Name=""				# script name
declare lmsscr_Version="0.0.1"		# main script version

# *****************************************************************************
#
#    lmsScriptFileName
#
#		set the global lmsscr_Name to the base name of this script
#
# *****************************************************************************
lmsScriptFileName()
{
	lmsscr_Directory=$PWD
	lmsscr_Path=$(dirname "$0")
	lmsscr_Name=$(basename "$1" .bash)
}

# *****************************************************************************
#
#    lmsScriptDisplayName
#
#		display the script name and version of this script
#
# *****************************************************************************
lmsScriptDisplayName()
{
	lmsScriptFileName $0
	lmsConioDisplay " "
	lmsConioDisplay "$(tput bold ; tput setaf 1)${lmsscr_Name} version ${lmsscr_Version}$(tput sgr0)"
}

