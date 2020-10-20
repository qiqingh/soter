	ulog wlan status "${SERVICE_NAME}, service_start()"
	STATUS=`sysevent get ${SERVICE_NAME}-status`
	if [ "started" = "$STATUS" ] || [ "starting" = "$STATUS" ]; then
		echo "${SERVICE_NAME} is starting/started, ignore the request"
		ulog wlan status "${SERVICE_NAME} is starting/started, ignore the request"
		return 1
	fi
	if [ "0" = "`syscfg_get bridge_mode`" ] && [ "started" != "`sysevent get lan-status`" ] ; then
		ulog wlan status "${SERVICE_NAME}, LAN is not started,ignore the request"
		return 1
	fi
	echo "${SERVICE_NAME}, service_start()"
	sysevent set ${SERVICE_NAME}-status starting
	wifi_onetime_setting
	if [ "0" != "`syscfg get bridge_mode`" ] && [ -f /etc/init.d/service_wifi/wifi_repeater.sh ] && [ "2" = "`syscfg_get wifi_bridge::mode`" ]; then
		echo "service_wifi service_start, repeater mode enabled"
		/etc/init.d/service_wifi/wifi_repeater.sh
	fi
	if [ "0" != "`syscfg get bridge_mode`" ] && [ -f /etc/init.d/service_wifi/wifi_sta_setup.sh ] && [ "1" = "`syscfg get wifi_bridge::mode`" ]; then
		/etc/init.d/service_wifi/wifi_sta_setup.sh
		source /etc/init.d/service_wifi/wifi_utils.sh
	fi
	for PHY_IF in $PHYSICAL_IF_LIST; do
		wifi_physical_start $PHY_IF
		wifi_virtual_start $PHY_IF
	done
	start_hostapd
	if [ "`syscfg_get wl_wmm_support`" = "enabled" ] && [ "`syscfg_get wl0_network_mode`" = "11b" ]; then
        	VAP_IF=`syscfg_get wl0_physical_ifname`
        	iwpriv $VAP_IF setwmmparams 1 0 1 4
        	iwpriv $VAP_IF setwmmparams 1 1 1 4
        	iwpriv $VAP_IF setwmmparams 1 2 1 3
        	iwpriv $VAP_IF setwmmparams 1 3 1 2
        	iwpriv $VAP_IF setwmmparams 2 0 1 10
        	iwpriv $VAP_IF setwmmparams 2 1 1 10
        	iwpriv $VAP_IF setwmmparams 2 2 1 4
        	iwpriv $VAP_IF setwmmparams 2 3 1 3
	fi
	sysevent set ${SERVICE_NAME}-status started
	return 0
