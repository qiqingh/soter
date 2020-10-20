	wait_till_end_state ${SERVICE_NAME}
	wait_till_end_state "wifi"
	if [ -z "`syscfg_get wifi_scheduler::if_enabled`" ] || [ "`syscfg_get wifi_scheduler::enabled`" != "1" ]; then
		return 1
	fi
	STATUS=`sysevent get ${SERVICE_NAME}-status`
	if [ "started" = "$STATUS" ] || [ "starting" = "$STATUS" ]; then
		return 1
	fi
	sysevent set ${SERVICE_NAME}-status starting
	wifi_scheduler_changed_handler
	sysevent set ${SERVICE_NAME}-status started
	return 0
