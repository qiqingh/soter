	echo "--------------------"
	echo "Start DPI System...."
	printf "\nCall $SETUP to start DPI System....\n"
	cd $MAIN_PATH
	$MAIN_PATH/$SETUP start
	cd $UPDATE_PATH

	printf "\t--------------------------\n"
	printf "\tCheck DPI System State....\n"
	# Start IDP
	if [ "$($LSMOD |grep $IDP)" ]; then
		printf "\t\tStart $IDP Success\n"
	else
		printf "\t\tStart $IDP Fail\n" && return "$FAIL_START_IDP"
	fi

	# Start Forwarding Module
	if [ "$($LSMOD |grep $FWD)" ]; then
		printf "\t\tStart $FWD Success\n"
	else
		printf "\t\tStart $FWD Fail\n" && return "$FAIL_START_FWD"
	fi

	# Start QOS
	if [ "$($LSMOD |grep $QOS)" ]; then
		printf "\t\tStart $QOS Success\n"
	else
		printf "\t\tStart $QOS Fail\n"  && return "$FAIL_START_QOS"
	fi

	return "$SUCC"
