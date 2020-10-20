	for PHY_IF in $PHYSICAL_IF_LIST; do
		WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
		USER_VAP=`syscfg get "${WL_SYSCFG}"_user_vap`
		if [ ! -z "$USER_VAP" ]; then
			PID=`ps | grep -e eapd -e nas | awk "/$USER_VAP/"' {print $1}'`
			kill $PID > /dev/null 2>&1
			DEBUG ulog wlan status "${SERVICE_NAME}, Stopped 1x Authentication agent on $USER_VAP"
		fi
	done
	PID=`ps | awk "/nas/"' {print $1}'`
	kill $PID > /dev/null 2>&1
	stop_driver_wps_process
	stop_auto_channel_process
