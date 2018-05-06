
if [[ ${lmscli_optProduction} -eq 1 ]]
then
	dirRoot="/usr/local"

	dirBash="${dirRoot}/share/LMS/Bash/${lmslib_release}"
	dirAppSrc="${dirBash}"

	dirEtc="${dirRoot}/etc/LMS/Bash/${lmslib_release}"
	dirLib="${dirRoot}/lib/LMS/Bash/${lmslib_release}"

	dirAppLog="/var/local/log/LMS/Bash/${lmslib_release}"
	dirAppBkup="/var/local/backup/LMS/Bash/${lmslib_release}"
else
	dirRoot=${PWD%"/$lmslib_release"*}

	dirBash="${dirRoot}/${lmslib_release}"
	dirAppSrc="${dirBash}/src"

	dirEtc="${dirBash}/etc"
	dirLib="${dirBash}/lib"

	dirAppLog="/var/local/log/LMS/Bash/${lmslib_release}/test"
	dirAppBkup="/media/sf_Shared/Backup/LMS/Bash/${lmslib_release}"
fi

dirSource="${dirAppSrc}/${lmsapp_name}"
dirAppLib="${dirAppSrc}/appLib"

dirAppTmp="/var/local/temp/LMS"

