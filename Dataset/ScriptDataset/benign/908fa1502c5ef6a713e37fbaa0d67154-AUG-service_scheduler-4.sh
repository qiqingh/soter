	wait_till_end_state ${SERVICE_NAME}
	ulog ${SERVICE_NAME} status "${SERVICE_NAME}, service_stop()"
	STATUS=`sysevent get ${SERVICE_NAME}-status`
	if [ "stopped" = "$STATUS" ] || [ "stopping" = "$STATUS" ] || [ -z "$STATUS" ]; then
		ulog ${SERVICE_NAME} status "${SERVICE_NAME} is stopping/stopped, ignore the request"
		return 0
	fi
	
	echo "${SERVICE_NAME}, service_stop()"
	sysevent set ${SERVICE_NAME}-status stopping
	sysevent set ${SERVICE_NAME}-status stopped
