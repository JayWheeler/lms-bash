
function testHighlightMessage()
{
	local message="${1}"
	local color=1

	lmsConioDisplay "$( tput bold ; tput setaf $color )     $message $( tput sgr0 )"
}

# ****************************************************************************
#
#	testIndentFmt
#
#		Add spaces (indentation) to the buffer
#
# 	Parameters:
#  		stackIndex = how many blocks to indent
#		buffer = buffer to add the spaces to
#		blockSize = (optional) number of spaces in a block
#
#	Returns:
#		0 = no error
#
# ****************************************************************************
function testIndentFmt()
{
	local -i indent=${1:-1}
	local -i bSize=${3:-4}

	(( bSize+=${indent}*${bSize} ))

	[[ ${indent} -gt 0 ]]  &&  printf -v ${2} "%s%*s" "${2}" ${indent}
	return 0
}

# *****************************************************************************
#
#	testDisplayHelp
#
#	parameters:
#		helpFile = path to the xml file
#
#	returns:
#		$? = 0 ==> no errors.
#
# *****************************************************************************
function testDisplayHelp()
{
	[[ -z "${lmshlp_XmlFile}" ]] &&
	 {
		lmsHelpInit ${1}
		[[ $? -eq 0 ]] ||
		 {
			lmstst_resultCode=$?
		lmsLogDisplay "lmsHelpInit '${1}' failed: ${lmstst_resultCode}"
			return ${lmstst_resultCode}
		 }
	 }

	[[ -z "${lmstst_buffer}" ]] &&
	 {
		lmstst_buffer=$( lmsHelpToStr )
		[[ $? -eq 0 ]] ||
		 {
			lmstst_resultCode=$?
			lmsLogDisplay "lmsHelpToStr failed: ${lmstst_resultCode}"
			return ${lmstst_resultCode}
		 }
	 }

	lmsConioDisplay ""	
	lmsConioDisplay "${lmstst_buffer}"
	lmsConioDisplay ""	

	return 0
}

# *****************************************************************************
#
#	testDomShowData
#
#		Show the xml dom element
#
# *****************************************************************************
function testDomShowData()
{
	local content

	lmsConioDisplay ""
	lmsConioDisplay "XML_ENTITY    : '${lmsdom_Entity}'"

	lmsConioDisplay "XML_CONTENT   :     '${lmsdom_Content}'"

	lmsConioDisplay "XML_TAG_NAME  :     '${lmsdom_TagName}'"
	lmsConioDisplay "XML_TAG_TYPE  :     '${lmsdom_TagType}'"

	[[ "${lmsdom_TagType}" == "OPEN" || "${lmsdom_TagType}" == "OPENCLOSE" ]] &&
	 {
		[[ ${lmsdom_attribCount} -eq 0 ]] ||
		 {
			lmsConioDisplay "XML_ATT_COUNT :     '${lmsdom_attribCount}'"
		
			for attribute in "${!lmsdom_attribs[@]}"
			do
				lmsConioDisplay "XML_ATT_NAME  :     '${attribute}'"
				lmsConioDisplay "XML_ATT_VAL   :     '${lmsdom_attribs[$attribute]}'"
				
			done
		 }
	 }

	lmsConioDisplay "XML_COMMENT   :     '${lmsdom_Comment}'"
	lmsConioDisplay "XML_PATH      :     '${lmsdom_Path}'"

	lmsConioDisplay "XPATH         :     '${lmsdom_XPath}'"
}



