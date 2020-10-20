	ulog wlan status "${SERVICE_NAME}, service_init()"
	SYSCFG_FAILED='false'
	FOO=`utctx_cmd get wifi_bridge::mode wifi_bridge::radio wifi_bridge::ssid bridge_mode`
	eval $FOO
	if [ $SYSCFG_FAILED = 'true' ] ; then
		ulog wlan status "${SERVICE_NAME}, $PID utctx failed to get some configuration data required by service-forwarding"
		DEBUG echo "[utopia] THE SYSTEM IS NOT SANE" > /dev/console
		sysevent set ${SERVICE_NAME}-status error
		sysevent set ${SERVICE_NAME}-errinfo "Unable to get crucial information from syscfg"
		return 0
	fi
