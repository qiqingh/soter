	if [ "0" != "`syscfg get bridge_mode`" ] && [ -f /etc/init.d/service_wifi/wifi_repeater.sh ] && [ "2" = "`syscfg_get wifi_bridge::mode`" ]; then
		echo "service_wifi service_start, repeater mode enabled"
		/etc/init.d/service_wifi/wifi_repeater.sh
	fi
	if [ "0" != "`syscfg get bridge_mode`" ] && [ -f /etc/init.d/service_wifi/wifi_sta_setup.sh ] && [ "1" = "`syscfg get wifi_bridge::mode`" ]; then
		echo "service_wifi service_start, wireless bridge mode enabled"
		/etc/init.d/service_wifi/wifi_sta_setup.sh
		source /etc/init.d/service_wifi/wifi_utils.sh
	fi
