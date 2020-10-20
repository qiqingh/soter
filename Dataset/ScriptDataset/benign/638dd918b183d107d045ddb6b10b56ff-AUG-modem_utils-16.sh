	echo "${SERVICE_NAME}, modem_reboot(), please wait..." > /dev/console
	ulog wlan status "${SERVICE_NAME}, modem_reboot(), please wait..."
	
	COMMAND="sys tpset sys reboot"
	RESULT=`process_command "$COMMAND"`
	is_dsl_up
	return 0
