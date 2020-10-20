	ErrorCode=2
	Debug "check_signature [$1]"
	if [ ! -e "$1" ]; then
		exit $ErrorCode
	fi
	check_gpg_signature "$1"
	if [ $? -ne 0 ]; then
		verify_linksys_header "$1"
	fi
