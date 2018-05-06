# *****************************************************************************
# *****************************************************************************
#
#   lmsUtilities.bash
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.0.4
# @copyright © 2016, 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package lmsUtilities
#
# *****************************************************************************
#
#	Copyright © 2016, 2017. EarthWalk Software
#	Licensed under the Academic Free License, version 3.0.
#
#	Refer to the file named License.txt provided with the source, or from
#
#			http://opensource.org/licenses/academic.php
#
# *****************************************************************************
#
#	version 0.0.1 - 08-24-2016.
#           0.0.2 - 08-26-2016.
#			0.0.3 - 12-18-2016.
#			0.0.4 - 02-08-2017.
#
# *****************************************************************************
# *****************************************************************************
declare -r lmslib_lmsUtilities="0.0.4"	# version of library

declare    lmsutl_osString
declare -a lmsutl_wmFields=( window winws winx winy winw winh winmachine wintitle )

# *****************************************************************************
#
#	lmsUtilCommandExists
#
#		check if the given external command has been installed
#
#	parameters:
#		cmnd = command to check for
#
#	outputs:
#		1 = found
#		0 = not found
#
#	returns:
#		0 = no errors
#
# *****************************************************************************
function lmsUtilCommandExists()
{
	local cmnd=${1}

	type ${cmnd} >/dev/null 2>&1
	[[ $? -eq 0 ]] && echo "1" || echo "0"

	return 0
}

# *****************************************************************************
#
#	lmsUtilVarExists
#
#		check if the given variable exists
#
#	parameters:
#		name = name of variable to check for
#
#	returns:
#		0 = found
#		1 = not found
#
# *****************************************************************************
function lmsUtilVarExists()
{
	local name="${1}"
	local type=${2:-""}

	declare -p | grep "$name" > /dev/null 2>&1
	[[ $? -eq 0 ]] && return 0
	
	return 1
}

# *****************************************************************************
#
#	lmsUtilIsArray
#
#		check if the given variable is an array
#
#	parameters:
#		name = name of variable to check
#
#	outputs:
#		"A" = associative array
#		"a" = indexed array
#		"s" = scalar (string or integer)
#		""  = unknown variable name
#
#	returns:
#		0 = is an array
#		1 = not an array
#
# *****************************************************************************
function lmsUtilIsArray()
{
	local name="${1}"
	
	declare -A | grep "$name" > /dev/null 2>&1
	[[ $? -eq 0 ]] &&
	 {
		echo "A" 	# associative array
		return 0
	 }

	declare -a | grep "$name" > /dev/null 2>&1
	[[ $? -eq 0 ]] &&
	 {
		echo "a"	# array
		return 0
	 }

	lmsUtilVarExists ${name}
	[[ $? -eq 0 ]] && echo "s" || echo ""

	return 1
}

# *******************************************************
#
#	lmsUtilIsUserType
#
#		outputs 1 for root (or sudoer) and 0 for user
#
#	parameters:
#		none
#
#	outputs:
#		"0" = user (non-root)
#		"1" = root (or sudoer)
#
#	returns:
#		0 = no errors
#
# *******************************************************
function lmsUtilIsUserType()
{
	local iAm=$( whoami )

    if [[ "${RUNUSER}" == "root" || "${iAm}" == "root" ]]
    then
    	echo "1"
    fi

	echo "0"

	return 0
}

# *******************************************************
#
#	lmsUtilIsRoot
#
#		outputs messages and exits script if not root
#
#	parameters:
#		none
#
#	returns:
#		0 = no errors
#
#	exits if not root
#
# *******************************************************
function lmsUtilIsRoot()
{
	local iAm=$( whoami )

	if [ "${iAm}" != "root" ]
	then
		lmsConioDisplay ""
		lmsConioDisplay "	User = ${iAm}"
		lmsConioDisplay ""
		lmsConioDisplay "		${baseName} can only be run by root."
		lmsConioDisplay ""

		lmsErrorExitScript NotRoot
	fi

	return 0
}

# *******************************************************
#
#    lmsUtilIsUser
#
#		outputs messages and exits script if not user
#
#	parameters:
#		none
#
#	returns:
#		0 = no errors
#
#	exits if not user
#
# *******************************************************
function lmsUtilIsUser()
{
    local iAm=$( whoami )

    if [[ "${RUNUSER}" == "root" || "${iAm}" == "root" ]]
    then
	    lmsConioDisplay ""
        lmsConioDisplay "    User = ${iAm} (${RUNUSER})"
	    lmsConioDisplay ""
        lmsConioDisplay "        ${baseName} can only be run by a sudo user."
	    lmsConioDisplay ""


		lmsErrorExitScript NotUser
    fi

    return 0
}

# *****************************************************************************
#
#	lmsUtilOsInfo
#
#		parse the os-release data into a dynamic array
#
#	parameters:
#		arrayName = dynamic array name to create
#
#	returns:
#		0 = no errors
#		non-zero = error code
#
# *****************************************************************************
function lmsUtilOsInfo()
{
	local arrayName=${1}

	local item
	local itemName
	local itemValue

	lmsDynaNew "${arrayName}" "A"
	[[ $? -eq 0 ]] ||
	{
		lmsLogDisplay "Unable to create dynArray: $arrayName"
		return 1
	}

	lmsutl_osString="$( cat /etc/os-release )"
	readarray -t osItems <<< "$lmsutl_osString"

	for item in "${osItems[@]}"
	do
		lmsStrSplit "${item}" itemName itemValue
		[[ $? -eq 0 ]] ||
		 {
    		lmsLogDisplay "lmsStrSplit failed: ${item}"
    		return 4
		 }

		lmsStrUnquote "${itemValue}" itemValue

		if [ -z "${itemValue}" ]
		then
			lmsLogDisplay "itemValue is null"
			return 5
		fi

		lmsDynaSetAt ${arrayName} $itemName "${itemValue}"
		[[ $? -eq 0 ]] ||
		 {
    		lmsLogDisplay "lmsDynaSetAt failed to add: ${itemName} to ${arrayName}"
    		return 6
		 }

		(( itemNumber++ ))
	done

	return 0
}

# *****************************************************************************
#
#	lmsUtilOsType
#
#		return the operating system type string
#
#	parameters:
#		arrayName = dynamic array name to create
#
#	outputs:
#		osName = short name of the operating system
#
#	returns:
#		0 = no errors
#		non-zero = error code
#
# *****************************************************************************
function lmsUtilOsType()
{
	local aName="${1}"

	local name=$( uname )

	[[ "${name}" == "^linux*" ]] &&
	 {
		lmsUtilOsInfo "${aName}"
		[[ $? -eq 0 ]] ||
		 {
			echo "error"
			return 1
		 }

		lmsDynaGetAt "${aName}" "ID" name
		[[ $? -eq 0 ]] ||
		 {
			echo "error"
			return 1
		 }

		[[ "${name}" == "linuxmint" ]] &&
		 {
			local like
			lmsDynaGetAt "${aName}" "ID_LIKE" like
			[[ $? -eq 0 ]] ||
			 {
				echo "error"
				return 1
			 }

			[[ -n "${like}" ]] && name="${like}"
		 }
	 }

	echo "${name}"
	return 0
}

# ****************************************************************************
#
#	lmsUtilIndent
#
#		Add spaces (indentation) to the buffer
#
# 	Parameters:
#  		index = how many 'blocks' to indent
#		buffer = buffer to add the spaces to
#		bSize = (optional) number of spaces in a block (default=4)
#
#	Returns:
#		0 = no error
#
# ****************************************************************************
function lmsUtilIndent()
{
	[[ -z "${1}" || -z "${2}" ]] && return 1

	local -i indent=${1}
	local -i bSize=${3:-4}

	(( bSize+=${indent}*${bSize} ))

	[[ ${indent} -gt 0 ]]  &&  printf -v ${2} "%s%*s" "${2}" ${bSize}
	return 0
}

# *****************************************************************************
#
#	lmsUtilATS
#
#		Create a printable string representation of a single array
#
#	parameters:
#		name = the name of the GLOBAL array to turn into a string
#		string = location to place the string
#
#	returns:
#		0 = no error
#		non-zero = error code
#
# ******************************************************************************
function lmsUtilATS()
{
	[[ -z "${1}" || -z "${2}" ]] && return 1

	local name="${1}"

	local arrayType=$( lmsUtilIsArray $name )

	local -i number

	local contents
	local key
	local keys

	eval 'keys=$'"{!$name[@]}"

	local msg=""
	printf -v msg "   %s:\n" ${name}

	for key in ${keys}
	do
		eval 'contents=$'"{$name[$key]}"

		[[ "${arrayType}" == "A" ]] &&
		 {
			printf -v msg "%s      [ %s ] = %s\n" "${msg}" "${key}" "${contents}"
			continue
		 }

		printf -v msg "%s      [ % 5u ] = %s\n" "${msg}" "${key}" "${contents}"
	done

	lmsDeclareStr ${2} "${msg}"
	[[ $? -eq 0 ]] || return 3

	return 0
}

# *****************************************************************************
#
#	lmsUtilWMList
#
#		returns an array of current windows and information
#
#	parameters:
#		wmList = Dynamic sequential array name to be created
#
#	returns:
#		0 = no errors
#		non-zero = error code
#
# *****************************************************************************
function lmsUtilWMList()
{
	local wmList="${1}"

	local wmArray
	local wmInfo

	OFS=$IFS
	IFS=$'\n'

	read -d '' -r -a wmArray <<< "$( wmctrl -lG )"

	IFS=$OFS

	lmsDynaNew "${wmList}" "a"
	[[ $? -eq 0 ]] ||
	 {
		lmsLogDisplay "Unable to get wmList!"
		return 1
	 }

	for wmInfo in "${wmArray[@]}"
	do
		lmsDynaAdd "${wmList}" "${wmInfo}"
		[[ $? -eq 0 ]] ||
		 {
			lmsLogDisplay "Unable to add '${wmInfo}' to '${wmList}'"
			return 2
		 }

	done

	return 0
}

# *****************************************************************************
#
#	lmsUtiltestLmsWMParse
#
#		parses window information record into an associative dynamic array
#
#	parameters:
#		testLmsWMParsed = the name of an  associative dynamic array to populate
#		wmInfo   = record to be parsed
#
#	returns:
#		0 = no errors
#		non-zero = error code
#
# *****************************************************************************
function lmsUtiltestLmsWMParse()
{
	local testLmsWMParsed="${1}"
	local wmInfo="${2}"

	lmsDynaRegistered ${testLmsWMParsed}
	[[ $? -eq 0 ]] &&
	 {
		lmsDynaNew "${testLmsWMParsed}" "A"
		[[ $? -eq 0 ]] ||
		 {
			lmsLogDisplay "Unable to create testLmsWMParsed!"
			return 1
		 }
	 }

	local fieldIndex=0
	local fieldCount=${#lmsutl_wmFields[@]}
	local titleStart=0

	lmsStrExplode "${wmInfo}"

	while [[ ${fieldIndex} -lt ${fieldCount} ]]
	do
		lmsDynaSetAt ${testLmsWMParsed} ${lmsutl_wmFields[$fieldIndex]} "${lmsstr_Exploded[$fieldIndex]}"
		[[ $? -eq 0 ]] ||
		 {
			lmsLogDisplay "Unable to add field named '${lmsutl_wmFields[$fieldIndex]}'!"
			return 2
		 }

		(( fieldIndex++ ))

		[[ ${fieldIndex} -lt ${fieldCount} ]] &&
		 {
			let titleStart=$titleStart+${#lmsstr_Exploded[$fieldIndex-1]}+1
		 }
	done

	let fieldIndex-=1
	lmsDynaSetAt "${testLmsWMParsed}" "${lmsutl_wmFields[$fieldIndex]}" "${wmInfo:$titleStart}"

	return 0
}


