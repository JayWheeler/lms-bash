lmscli_optDevelopment=1

if [[ ${lmscli_optDevelopment} -eq 0 ]]
then
	dirRoot="/usr/local"

	dirBash="${dirRoot}/share/LMS/Bash"
	dirRelease="${dirBash}/${lmslib_release}"

	dirAppLog="/var/local/log/LMS/Bash/${lmslib_release}/test"

	dirAppSrc="${dirRelease}/test"

	dirEtc="${dirRoot}/etc/LMS/Bash/${lmslib_release}"
	dirLib="${dirRoot}/lib/LMS/Bash/${lmslib_release}"
else
	dirRoot=${PWD%"/$lmslib_release"*}

	dirBash="${dirRoot}"
	dirRelease="${dirBash}/${lmslib_release}"

	dirAppLog="/var/local/log/LMS/Bash/${lmslib_release}/test"

	dirAppSrc="${dirRelease}/test"

	dirEtc="${dirRelease}/etc"
	dirLib="${dirRelease}/lib"
fi

dirSource="${dirAppSrc}/${lmsapp_name}"
dirAppLib="${dirAppSrc}/testlib"

