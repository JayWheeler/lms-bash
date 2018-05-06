# **************************************************************************
#
#	testLmsDmpVarStack
#
#      dump call stack
#
#	parameters:
#		none
#
#	Returns
#		0 = no error
#		1 = error
#
# **************************************************************************
function testLmsDmpVarStack()
{
	lmsDmpVarStack
	lmsConioDisplay ""
}

# **************************************************************************
#
#	testLmsDmpVar
#
#      dump selected varialbes
#
#	parameters:
#		arrayName = name of the array to iterate
#
#	Returns
#		0 = no error
#		1 = error
#
# **************************************************************************
function testLmsDmpVar()
{
	local lmsVars=${1:-"lmstst_ lmscli_"}

	local varList
	lmsStrExplode "${1}" " " varList

	local varName
	for varname in "${varList[@]}"
	do
		lmsDmpVarSelected "${varname}"
		lmsConioDisplay ""
	done

	lmsConioDisplay "---------------------------"
	lmsConioDisplay ""
}

# **************************************************************************
#
#	testDumpExit
#
#      dump selected varialbes and exit
#
#	parameters:
#		arrayName = name of the array to iterate
#
#	Returns
#		0 = no error
#		1 = error
#
# **************************************************************************
function testDumpExit()
{
	testLmsDmpVar "${1}"
	exit 1
}

