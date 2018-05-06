# *****************************************************************************
# *****************************************************************************
#
#   lmsErrorQDisp.bash
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.1.1
# @copyright © 2016, 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package Linux Management Scripts
# @subpackage lmsErrorQDisp
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
#			Version 0.0.1 - 03-27-2016.
#					0.1.0 - 01-16-2017.
#					0.1.1 - 01-25-2017.
#
# *****************************************************************************
# *****************************************************************************

declare -r lmslib_lmsErrorQDisp="0.1.1"	# version of the library

# *****************************************************************************
#
#	lmsErrorQDispDetail
#
#		Display the error messages in exploded format
#
#	Parameters:
#		qName = queue name
#		qResult = return buffer
#		qElement = record number
#
#	Returns:
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function lmsErrorQDispDetail()
{
	local    qName=${1}
	local    qResult="${2}"
	local    qElement=$3

	lmsErrorLookupName ${qName} "${lmserr_QError}"
	[[ $? -eq 0 ]] || return 1

	lmserr_QErrorDesc="$lmserr_message"

	lmsConioDisplay "$qElement - ${qResult}"
	lmsConioDisplay ""
	lmsConioDisplay "   Time:            $lmserr_QDateTime"
	lmsConioDisplay "   Line-number:     $lmserr_QLine"
	lmsConioDisplay "   Source:          $lmserr_QScript"
	lmsConioDisplay "   Function:        $lmserr_QFunction"
	lmsConioDisplay "   Error:           $lmserr_QError"
	lmsConioDisplay "   Description:     $lmserr_QErrorDesc"
	lmsConioDisplay "   Error-modifier:  $lmserr_QErrorMod"
	lmsConioDisplay ""

	return 0
}

# *****************************************************************************
#
#	lmsErrorQDispOutput
#
#		Display the error messages in exploded format
#
#	Parameters:
#		qName = queue name
#		qResult = result to display
#		qElement = record number to display
#		qDetail = (optional) 0 => no detail (default), non-zero => detail
#
#	Returns:
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function lmsErrorQDispOutput()
{
	local    qName=${1}
	local    qResult="${2}"
	local    qElement=${3:-0}
	local -i qDetail=${4:-0}

	[[ ${4} -ne 0 ]] &&
	 {
		lmsErrorQDispDetail "${qName}" "${qResult}" ${qElement}
		return $?
	 }

	printf "% 4u %s - %s @ % u in %s:%s\n" ${qElement} "$lmserr_QDateTime" "$lmserr_QError" $lmserr_QLine "$lmserr_QScript" "$lmserr_QFunction"
	printf "    %s (%s)\n" "${lmserr_QErrorDesc}" "${lmserr_QErrorMod}"

	return 0
}

# *****************************************************************************
#
#	lmsErrorQDispPeek
#
#		Non-volatile listing of the error queue stack
#
#	Parameters:
#		qName = queue name
#		qDetail = 0 => standard detail, 1 => full detail
#
#	Returns:
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function lmsErrorQDispPeek()
{
	local    qName=${1}
	local -i qDetail=${2:-0}
	local    qResult=""
	local    qElement=0

	local    qCount

	lmscli_optQueueErrors=0
	lmserr_result=0

	lmsErrorQErrors "${qName}" qCount
	[[ $? -eq 0 ]] || 
	 {
		lmserr_result=$?
		return 1
	 }

	lmserr_result=0
	while [[ $lmserr_result -eq 0  &&  $qElement -lt $qCount ]]
	do
		qResult=""
		lmsErrorQPeek ${qName} qResult $qElement
		[[ $? -eq 0 ]] || break

		lmsErrorQDispOutput ${qName} "${qResult}" ${qElement} ${qDetail}
		[[ $? -eq 0 ]] || break
#		{
#			lmserr_result=$?
#			return 3
#		}

		(( qElement++ ))
	done

	lmscli_optQueueErrors=1
	return 0
}

# *****************************************************************************
#
#	lmsErrorQDispPop
#
#		Volatile listing of the error queue stack
#
#	Parameters:
#		qName = name of the error queue
#		qDetail = 0 => standard detail, 1 => full detail
#
#	Returns:
#		0 = no error
#		non-zero = error code
#
# *****************************************************************************
function lmsErrorQDispPop()
{
	local    qName=${1}
	local -i qDetail=${2:-0}

	local    qResult=""
	local    qCount

	lmsErrorQErrors ${qName} qCount
	[[ $? -eq 0 ]] || return 1

	while [[ $qCount -gt 0 ]]
	do
		(( qCount-- ))

		lmsErrorQRead ${qName} qResult
		[[ $? -eq 0 ]] || return 2

		lmsErrorQDispOutput ${qName} "${qResult}" ${qCount} ${qDetail}
		[[ $? -eq 0 ]] || return 3
	done

	return 0
}

