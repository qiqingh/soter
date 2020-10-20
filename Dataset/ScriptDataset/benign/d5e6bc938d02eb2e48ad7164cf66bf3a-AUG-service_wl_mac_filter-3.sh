	ulog ${SERVICE_NAME} status "mac filter service init"
	SYSCFG_FAILED='false'
	FOO=`utctx_cmd get wl_mac_filter wl_access_restriction wl_client_list`
	eval $FOO
	if [ $SYSCFG_FAILED = 'true' ] ; then
		ulog ${SERVICE_NAME} status "$PID utctx failed to get some configuration data required by service_wl_mac_filter"
		sysevent set ${SERVICE_NAME}-status error
		sysevent set ${SERVICE_NAME}-errinfo "Unable to get crucial information from syscfg"
		exit
	fi
