	ulog ${SERVICE_NAME} status "wps pbc service init"
	SYSCFG_FAILED='false'
	FOO=`utctx_cmd get wl0_ssid wl1_ssid`
	eval $FOO
	if [ $SYSCFG_FAILED = 'true' ] ; then
		ulog ${SERVICE_NAME} status "$PID utctx failed to get some configuration data required by service $SERVICE_NAME"
		sysevent set ${SERVICE_NAME}-status error 
		sysevent set ${SERVICE_NAME}-errinfo "failed to get crucial information from syscfg"
		exit
	fi
