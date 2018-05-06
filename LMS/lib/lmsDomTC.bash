# *****************************************************************************
# *****************************************************************************
#
#   	lmsDomTC.bash
#
# *****************************************************************************
#
# @author Jay Wheeler.
# @version 0.0.4
# @copyright © 2016, 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package Linux Management Scripts
# @subpackage lmsDomTCConfig
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
#			Version 0.0.1 - 09-07-2016.
#			        0.0.2 - 09-15-2016.
#					0.0.3 - 02-10-2017.
#					0.0.4 - 02-15-2017.
#
# *****************************************************************************
# *****************************************************************************

declare -r lmslib_lmsDomTC="0.0.4"		# version of this library

# *****************************************************************************
# *****************************************************************************

declare    lmsdtc_stackName="DTCBranches"
declare -A lmsdtc_attributes=()

# ****************************************************************************
#
#	lmsDomTCGetAtt
#
# 	Parameters:
#		aUid = uid of the node
#
#	Returns:
#		0 = no error
#		non-zero = error code
#
# ****************************************************************************
lmsDomTCGetAtt()
{
	local aUid=${1}

	local attName="lmsdom_${aUid}_att"  # name of the dynamic attribute array
	local attKey						# attribute name
	local attValue						# attribute value
	local itValid

	lmsDynnReset ${attName}
	[[ $? -eq 0 ]] || return 0

	lmsDynnValid ${attName} itValid
	[[ $? -eq 0 ]] || return 1

	while [[ itValid -eq 0 ]]
	do
		lmsDynnGet ${attName} attValue		# next attribute value
		[[ $? -eq 0 ]] &&
		 {
			lmsDynnMap ${attName} attKey	# attribute name
			[[ $? -eq 0 ]] ||
			{
				lmsLogDebugMessage $LINENO "DOMError" "IteratorMap failed for ${attName}"
				return 1
			}

			lmsdtc_attributes[$attKey]="${attValue}"
		 }

		lmsDynnNext ${attName}

		lmsDynnValid ${attName} itValid
		[[ $? -eq 0 ]] || return 1
	done

	[[ "${!lmsdtc_attributes[@]}" =~ "name"  ]] || return 2
	[[ "${!lmsdtc_attributes[@]}" =~ "type"  ]] || lmsdtc_attributes["type"]="string"
	[[ "${!lmsdtc_attributes[@]}" =~ "value" ]] || lmsdtc_attributes["value"]=0

	return 0
}

# ****************************************************************************
#
#	lmsDomTCDclV
#
#		Declare variable attributes
#
# 	Parameters:
#  		uid = node uid to declare
#
#	Returns:
#		0 = no error
#		non-zero = error code
#
# ****************************************************************************
lmsDomTCDclV()
{
	local uid=${1}

	local node="lmsdom_${uid}_node"
	local attCount

	lmsDynaGetAt $node "attcount" attCount
	[[  $? -eq 0 ]] || return 1
		
	lmsdtc_attributes=()
	
	[[ ${attCount} -gt 0 ]] &&
	 {
		lmsDomTCGetAtt ${uid}
		[[  $? -eq 0 ]] || return 1
	 }

	lmsDynaGetAt $node "content" content
	[[ -n "${content}" ]] &&
	 {
		lmsdtc_attributes["value"]="${content}"
	 }

	lmserr_result=0

	case ${lmsdtc_attributes["type"]} in

		"integer")
			[[ -n "${attribName}" ]] &&
			{
				lmsLogDebugMessage $LINENO "Debug" "attrib '${attribName}' - value '${lmsdtc_attributes[value]}'"
				lmsDeclareInt ${attribName} "${lmsdtc_attributes[value]}"
				lmserr_result=$?
			}
			;;

		"array")

			lmsDeclareArray lmsdtc_attributes["name"] "${lmsdtc_attributes[value]}"
			lmserr_result=$?
			;;

		"associative")

			lmsDeclareAssoc lmsdtc_attributes["name"] "${lmsdtc_attributes[value]}"
			lmserr_result=$?
			;;

		"element")

			[[ "${!lmsdom_attArray[@]}" =~ "parent" ]] &&
			 {
				lmsLogDebugMessage $LINENO "DOMError" "Missing parent name."
				return 1
			 }

			lmsDeclareArrayEl lmsdtc_attributes["parent"] lmsdtc_attributes["name"] "${lmsdtc_attributes[value]}"
			;;

		"password")

			lmsDeclarePwd lmsdtc_attributes["name"] "${lmsdtc_attributes[value]}"
			lmserr_result=$?
			;;

		"string")

			lmsDeclareStr lmsdtc_attributes["name"] "${lmsdtc_attributes[value]}"
			lmserr_result=$?
			;;

		*)

			lmsDeclareStr lmsdtc_attributes["name"] "${lmsdtc_attributes[value]}"
			lmserr_result=$?
			;;
							
	esac
					
	[[ ${lmserr_result} -eq 0 ]] ||
	 {
		lmsLogDebugMessage $LINENO "DOMError" "Declare variable '${lmsdtc_attributes[name]}' failed."
		return 1
	 }

	return 0
}

# ****************************************************************************
#
#	lmsDomTCTraverse
#
#		A recursive descent function to traverse all limbs on the
#		requested branch
#
# 	Parameters:
#  		branch = branch node to start the traversal
#
#	Returns:
#		0 = no error
#		non-zero = error code
#
# ****************************************************************************
lmsDomTCTraverse()
{
	local branch=${1}

	local branchName="lmsdom_${branch}"

	local limbs=0
	local limb

	lmsLogDebugMessage $LINENO "Debug" "Traverse branch : '${branch}'"

	lmsStackWrite ${lmsdtc_stackName} ${branch}
	[[ $? -eq 0 ]] ||
	 {
		lmsLogDebugMessage $LINENO "DOMError" "Unable to write ${branch} to stack named '${lmsdtc_stackName}'"
		return 1
	 }

	lmsDynnReset "$branchName"
	[[ $? -eq 0 ]] ||
	 {
		lmsLogDebugMessage $LINENO "DOMError" "lmsDynnReset '$branchName' failed."
		return 1
	 }

	dynaArrayITValid "$branchName" lmserr_result
	[[$? -eq 0 ]] || return 1

	while [[ ${lmserr_result} -eq 0 ]]
	do
		lmsDynnGet "$branchName" limb
		[[ $? -eq 0 ]] ||
		 {
			lmsLogDebugMessage $LINENO "DOMError" "lmsDynnGet failed."
			return 1
		 }

		lmsDomTCDclV ${limb}
		[[ $? -eq 0 ]] ||
		 {
			lmsLogDebugMessage $LINENO "DOMError" "DeclareVar '${branchName}' failed."
			return 1
		 }

		lmsLogDebugMessage $LINENO "Debug" "lmsDomTCDclV added '${branchName}'"

		lmsDomTCTraverse $limb
		[[ $? -eq 0 ]] ||
		 {
			lmsLogDebugMessage $LINENO "DOMError" "Traverse '${limb}' failed."
			return 1
		 }

		lmsStackPeek "${lmsdtc_stackName}" branch
		[[ $? -eq 0 ]] ||
		 {
			lmsLogDebugMessage $LINENO "DOMError" "Stack peek '${lmsdtc_stackName}' failed."
			return 1
		 }

		branchName="lmsdom_${branch}"

		lmsDynnNext "$branchName"

		lmsDynnValid "$branchName" lmserr_result
		[[ $? -eq 0 ]] || return 1
	done

	lmsLogDebugMessage $LINENO "Debug" "lmsStackPeek '$lmsdtc_stackName' => '${branch}'"

	lmsStackRead ${lmsdtc_stackName} branch
	[[ $? -eq 0 ]] ||
	 {
		[[ $? -eq 2 ]]
		{
			lmsLogDebugMessage $LINENO "DOMError" "Stack pop EMPTY stack '${lmsdtc_stackName}'."
			return 0
		}

		lmsLogDebugMessage $LINENO "DOMError" "Stack pop '${lmsdtc_stackName}' failed."
		return 1
	 }
	
	lmsLogDebugMessage $LINENO "Debug" "lmsStackRead '$lmsdtc_stackName' ${branch}"

	return 0
}

# ****************************************************************************
#
#	lmsDomTCConfig
#
# 	Parameters:
#  		none
#
#	Returns:
#		0 = no error
#		non-zero = error code
#
# ****************************************************************************
lmsDomTCConfig()
{
	local stackUid

	if [[ -z "${lmsdom_docTree}" ]]
	then
		lmsLogDebugMessage $LINENO "DomError" "Root is not set... terminating lmsDomTCConfig"
		echo "Root is not set... terminating lmsDomTCConfig"
		return 1
	fi

	lmsStackExists "${lmsdtc_stackName}" stackUid
	[[ $? -eq 0 ]] && stackUnset ${lmsdtc_stackName}

	lmsStackCreate ${lmsdtc_stackName} stackUid 12
	[[ $? -eq 0 ]] ||
	 {
		lmsLogDebugMessage $LINENO "DOMError" "Unable to create stack named '${lmsdtc_stackName}'"
		return 2
	 }

	lmserr_result=0

	lmsDomTCTraverse ${lmsdom_docTree}
	[[ $? -eq 0 ]] ||
	 {
		lmserr_result=$?
	 }

declare -p | grep lmstest_

	return ${lmserr_result}
}


