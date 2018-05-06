# *****************************************************************************
# *****************************************************************************
#
#   lmsCliNode.bash
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.0.1
# @copyright © 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package Linux Management Scripts
# @subpackage lmsCli
#
# *****************************************************************************
#
#	Copyright © 2017. EarthWalk Software
#	Licensed under the Academic Free License, version 3.0.
#
#	Refer to the file named License.txt provided with the source,
#	or from
#
#			http://opensource.org/licenses/academic.php
#
# *****************************************************************************
#
#			Version 0.0.1 - 02-12-2017.
#
# *****************************************************************************
# *****************************************************************************

declare    lmslib_lmsCliNode="0.0.1"			# library version number

declare    lmsclin_valid=0						# validity of the current argument pointer
declare    lmsclin_node=""						# node name

# ******************************************************************************
# ******************************************************************************
#
#		Functions - general purpose user functions
#
# ******************************************************************************
# ******************************************************************************

# ******************************************************************************
#
#	lmsClinName
#
#		Return the current cli command argument name and value
#
#	parameters:
#		command = the cli command
#		cmndNum = command stack level
#		name = location to place the name
#
#	returns:
#		0 = no error
#		non-zero = error code
#
# ******************************************************************************
function lmsClinName()
{
	[[ -z "${1}" || -z "${2}" | -z "${3}" ]] && return 1

	printf -v ${3} "lmsclin_%s%05u" ${1} ${2}
	return 0
}

# ******************************************************************************
#
#	lmsClinCurrent
#
#		Return the current cli command argument name and value
#
#	parameters:
#		node = the name of the cli command node
#		value = location to place the value at the mapped iterator key
#		name = location to place the iterator key
#
#	returns:
#		0 = no error
#		non-zero = error code
#
# ******************************************************************************
function lmsClinCurrent()
{
	[[ -z "${1}" || -z "${2}" | -z "${3}" ]] && return 1

	lmsDynnMap ${1} ${2} ${3} 
	[[ $? -eq 0 ]] && return 0

	return 2
}

# ******************************************************************************
#
#	lmsClinNext
#
#		Advance to the next argument
#
#	parameters:
#		nodeName = the name of the cli command to create
#
#	returns:
#		0 = no error
#		non-zero = error code
#
# ******************************************************************************
function lmsClinNext()
{
	[[ -z "${1}" ]] && return 1

	lmsDynnNext ${1}
	[[ $? -eq 0 ]] && return 0

	return 2
}

# ******************************************************************************
#
#	lmsClinReset
#
#		Reset the iterator to the first argument
#
#	parameters:
#		nodeName = the name of the cli command to create
#
#	returns:
#		0 = no error
#		non-zero = error code
#
# ******************************************************************************
function lmsClinReset()
{
	[[ -z "${1}" ]] && return 1

	lmsDynnReset ${lmsclin_node}
	[[ $? -eq 0 ]] && return 0

	return 2
}

# ******************************************************************************
#
#	lmsClinValid
#
#		check the validity of the current argument pointer
#
#	parameters:
#		node = the name of the cli command to create
#		valid = location to store the result
#
#	returns:
#		0 = no error
#		non-zero = error code
#
# ******************************************************************************
function lmsClinValid()
{
	[[ -z "${1}" || -z "${2}" ]] && return 1

	lmsDynnValid ${1} ${2}
	[[ $? -eq 0 ]] && return 0

	return 2
}


