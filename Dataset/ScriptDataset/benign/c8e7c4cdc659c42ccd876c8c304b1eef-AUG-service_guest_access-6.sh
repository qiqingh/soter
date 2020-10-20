	if [ "started" = "`sysevent get wan-status`" ] && [ "started" = "`sysevent get wifi_user-status`" ] ; then
		service_start 
	else
		service_stop
	fi
