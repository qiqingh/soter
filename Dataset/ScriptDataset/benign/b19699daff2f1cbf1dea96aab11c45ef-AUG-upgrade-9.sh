	printf "Update DPI System\n"

	stop_sys
	RET=$?
	if [ "$RET" == "$SUCC" ]; then
		printf "\tStop DPI succesfully\n"
	else
		printf "\tStop DPI fail\n" && exit "$RET"
	fi

	backup_file
	RET=$?
	if [ "$RET" == "$SUCC" ]; then
		printf "\tBackup DPI succesfully\n"
	else
		printf "\tBackup DPI fail\n" && restore_file
	fi

	update_file
	RET=$?
	if [ "$RET" == "$SUCC" ]; then
		printf "\tUpdate DPI succesfully\n"
	else
		printf "\tUpdate DPI fail\n" && restore_file
	fi

	start_sys
	RET=$?
	if [ "$RET" == "$SUCC" ]; then
		printf "\tStart DPI succesfully\n"
		archive_file
		RET=$?
		if [ "$RET" == "$SUCC" ]; then
			printf "\tArchive DPI succesfully\n"
		else
			printf "\tArchive DPI fail\n" && restore_file
		fi
	else
		printf "\tStart DPI fail\n" && restore_file
	fi

	exit "$SUCC"
