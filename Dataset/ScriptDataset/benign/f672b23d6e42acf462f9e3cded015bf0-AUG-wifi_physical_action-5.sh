	PHY_IF=$1
	IF_NAME=`get_syscfg_interface_name $PHY_IF`
	wait_till_end_state ${PHYSICAL_ACTION}_${PHY_IF}
	VALID=`is_physical_interface_valid ${PHY_IF}`
	if [ "${VALID}" = "0" ]; then
		ulog wlan status "${SERVICE_NAME}, Invalid interface: ${PHY_IF}"
		return 0
	fi
	STATUS=`sysevent get ${PHYSICAL_ACTION}_${PHY_IF}-status`
	if [ "started" = "$STATUS" ] || [ "starting" = "$STATUS" ] ; then
		ulog wlan status "${SERVICE_NAME}, ${PHYSICAL_ACTION}_${PHY_IF} is starting/started, ignore the request"
		return 0
	fi
	ulog wlan status "${SERVICE_NAME}, wifi_physical_action_start(${PHY_IF})"
	sysevent set ${PHYSICAL_ACTION}_${PHY_IF}-status starting
	wifi_runtime_setting ${PHY_IF}
	configure_mbss $PHY_IF
	update_wifi_cache "physical" "$IF_NAME"
	sysevent set ${PHYSICAL_ACTION}_${PHY_IF}-status started
	return 0
