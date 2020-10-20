	printf "\t--------------------\n"
	printf "\tcopyfiles from $1 to $2....\n"

	# copy IDP to indicated location
	if [ -f $1/$IDP.ko ]; then
		printf "\t\tcopy $IDP.ko from $1 to $2\n"
		[ "$($CP $1/$IDP.ko $2/)" ] && printf "\t\tcopy $IDP.ko fail\n" && return "$FAIL_MOVE_IDP"
	else
		printf "\t\t$1/$IDP.ko doesn't exist\n" && return "$FAIL_MOVE_IDP"
	fi

	# copy bw_forward to indicated location
	if [ -f $1/$FWD.ko ]; then
		printf "\t\tcopy $FWD.ko from $1 to $2\n"
		[ "$($CP $1/$FWD.ko $2/)" ] && printf "\t\tcopy $FWD.ko fail\n" && return "$FAIL_MOVE_FWD"
	else
		printf "\t\t$1/$FWD.ko doesn't exist\n" && return "$FAIL_MOVE_FWD"
	fi

	# copy QOS to indicated location
	if [ -f $1/$QOS.ko ]; then
		printf "\t\tcopy $QOS.ko from $1 to $2\n"
		[ "$($CP $1/$QOS.ko $2/)" ] && printf "\t\tcopy $QOS.ko fail\n" && return "$FAIL_MOVE_QOS"
	else
		printf "\t\t$1/$QOS.ko doesn't exist\n" && return "$FAIL_MOVE_QOS"
	fi

	return "$SUCC"
