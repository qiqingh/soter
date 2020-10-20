	printf "\t--------------------\n"
	printf "\tMove files from $1 to $2....\n"

	# Move IDP to indicated location
	if [ -f $1/$IDP.ko ]; then
		printf "\t\tMove $IDP.ko from $1 to $2\n"
		[ "$($MV $1/$IDP.ko $2)" ] && printf "\t\tMove $IDP.ko fail\n" && return "$FAIL_MOVE_IDP"
	else
		printf "\t\t$1/$IDP.ko doesn't exist\n" && return "$FAIL_MOVE_IDP"
	fi

	# Move bw_forward to indicated location
	if [ -f $1/$FWD.ko ]; then
		printf "\t\tMove $FWD.ko from $1 to $2\n"
		[ "$($MV $1/$FWD.ko $2)" ] && printf "\t\tMove $FWD.ko fail\n" && return "$FAIL_MOVE_FWD"
	else
		printf "\t\t$1/$FWD.ko doesn't exist\n" && return "$FAIL_MOVE_FWD"
	fi

	# Move QOS to indicated location
	if [ -f $1/$QOS.ko ]; then
		printf "\t\tMove $QOS.ko from $1 to $2\n"
		[ "$($MV $1/$QOS.ko $2)" ] && printf "\t\tMove $QOS.ko fail\n" && return "$FAIL_MOVE_QOS"
	else
		printf "\t\t$1/$QOS.ko doesn't exist\n" && return "$FAIL_MOVE_QOS"
	fi

	return "$SUCC"
