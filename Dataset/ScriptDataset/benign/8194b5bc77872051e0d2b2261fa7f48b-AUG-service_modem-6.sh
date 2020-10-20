	echo "${SERVICE_NAME}, modem_auto_config_handler()"
	ulog wlan status "${SERVICE_NAME}, modem_auto_config_handler()"
	if [ `sysevent get modem_detection_status` != "FOUND" ]; then
		echo "${SERVICE_NAME}, modem not found... ignore request"
		ulog wlan status "${SERVICE_NAME}, modem not found... ignore request"
		return 1
	fi
	/etc/init.d/service_modem/modem_auto_config.sh &
	return 0
