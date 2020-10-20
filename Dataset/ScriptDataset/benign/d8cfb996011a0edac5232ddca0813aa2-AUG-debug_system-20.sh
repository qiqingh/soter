	printf "#############################################check email registor##########################################\n"
	objReq account show
	printf "========================================\n"
	[ -f "/tmp/emailReg" ] && { cat /tmp/emailReg ; }
	printf "========================================\n"
	[ -f "/tmp/emailRegRet" ] && { cat /tmp/emailRegRet ; }
	printf "\n"
