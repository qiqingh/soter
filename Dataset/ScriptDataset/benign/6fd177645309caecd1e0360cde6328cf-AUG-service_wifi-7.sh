	ulog wlan status "${SERVICE_NAME}, ER_config_changed_handler()"
	ER_CONFIG_CHANGED=`sysevent get wifi_nvram_setting`
	if [ "changed" = "$ER_CONFIG_CHANGED" ]; then
		save_wps_settings_to_syscfg
		set_guest_ssid
		wifi_config_changed_handler
		sysevent set wifi_nvram_setting ""
	fi
