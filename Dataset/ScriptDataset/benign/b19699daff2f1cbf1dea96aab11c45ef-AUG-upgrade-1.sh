	echo "--------------------"
	echo "Stop DPI System...."
	printf "\nCall $SETUP to stop DPI System....\n"
	cd $MAIN_PATH
	$MAIN_PATH/$SETUP stop
	cd $UPDATE_PATH

	printf "\t--------------------------\n"
	printf "\tCheck DPI System State....\n"
	# Stop Forwarding Module
	if [ "$($LSMOD |grep $FWD)" ]; then
		printf "\t\tRemove $FWD fail\n" && return "$FAIL_STOP_FWD"
	else
		printf "\t\tRemove $FWD Success\n"
	fi

	# Stop IDP
	if [ "$($LSMOD |grep $IDP)" ]; then
		printf "\t\tRemove $IDP fail\n" && return "$FAIL_STOP_IDP"
	else
		printf "\t\tRemove $IDP Success\n"
	fi

	# Stop QOS
	if [ "$($LSMOD |grep $QOS)" ]; then
		printf "\t\tStop $QOS Fail\n" && return "$FAIL_STOP_QOS"
	else
		printf "\t\tStop $QOS Success\n"
	fi

	return "$SUCC"
