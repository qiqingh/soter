	echo "${SERVICE_NAME}, modem_config_changed_handler()"
	ulog wlan status "${SERVICE_NAME}, modem_config_changed_handler()"
	if [ `sysevent get modem_detection_status` != "FOUND" ]; then
		echo "${SERVICE_NAME}, modem not found... ignore request"
		ulog wlan status "${SERVICE_NAME}, modem not found... ignore request"
		return 1
	fi
	/etc/init.d/service_modem/modem_manual_config.sh &
	return 0
