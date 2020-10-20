	ulog ${SERVICE_NAME} status "wps pbc service start"
	sysevent set wps_process incomplete
	killall -q wps_monitor.sh
	killall -q start_wps.sh
	$WPS_HANDLER wps_pbc &
	$WPS_MONITOR &
	sysevent set ${SERVICE_NAME}-errinfo "wps hw button is pressed"
	sysevent set ${SERVICE_NAME}-status "started"
	return 0
