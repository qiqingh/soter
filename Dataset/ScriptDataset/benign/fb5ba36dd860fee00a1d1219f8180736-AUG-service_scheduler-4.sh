	wait_till_end_state ${SERVICE_NAME}
	if [ -z "`syscfg_get wifi_scheduler::if_enabled`" ] || [ "`syscfg_get wifi_scheduler::enabled`" != "1" ]; then
		return 1
	fi
	STATUS=`sysevent get ${SERVICE_NAME}-status`
	if [ "stopped" = "$STATUS" ] || [ "stopping" = "$STATUS" ] || [ -z "$STATUS" ]; then
		return 1
	fi
	
	sysevent set ${SERVICE_NAME}-status stopping
	sysevent set ${SERVICE_NAME}-status stopped
	return 0
