	wait_till_end_state ${SERVICE_NAME}
	wait_till_end_state "wifi"
	ulog ${SERVICE_NAME} status "${SERVICE_NAME}, service_start()"
	STATUS=`sysevent get ${SERVICE_NAME}-status`
	if [ "started" = "$STATUS" ] || [ "starting" = "$STATUS" ]; then
		ulog ${SERVICE_NAME} status "${SERVICE_NAME} is starting/started, ignore the request"
		return 0
	fi
	if [ "0" = "`syscfg get bridge_mode`" ] && [ "started" != "`sysevent get lan-status`" ] ; then
		ulog ${SERVICE_NAME} status "${SERVICE_NAME}, LAN is not started, ignore the request"
		return 0
	fi
	if [ -z "`syscfg get wifi_scheduler::if_enabled`" ]; then
		ulog ${SERVICE_NAME} status "${SERVICE_NAME}, service scheduler is not enabled, ignore the request"
		return 0
	fi
	echo "${SERVICE_NAME}, service_start()"
	sysevent set ${SERVICE_NAME}-status starting
	wifi_scheduler_changed_handler
	sysevent set ${SERVICE_NAME}-status started
