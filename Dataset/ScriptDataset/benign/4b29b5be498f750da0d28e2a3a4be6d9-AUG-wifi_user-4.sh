	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	VIR_IF=`syscfg_get "$SYSCFG_INDEX"_user_vap`
	
	if [ "true" = "$RECONFIGURE" ]; then
		return 1
	fi
	REPEATER_DISABLED=`syscfg_get repeater_disabled`
	if [ ! -z "$REPEATER_DISABLED" ] && [ "1" = "$REPEATER_DISABLED" ]; then
		syscfg_set ${SYSCFG_INDEX}_state "down"
		return 1
	fi
	LAN_IFNAME=`syscfg_get lan_ifname`
	add_interface_to_bridge $VIR_IF $LAN_IFNAME
	set_wps_state ${SYSCFG_INDEX}
	VIR_SSID=`syscfg_get "$SYSCFG_INDEX"_ssid`
	iwconfig $VIR_IF essid $VIR_SSID
	SEC_MODE=`get_security_mode "$SYSCFG_INDEX"_security_mode`
	USE_HOSTAPD=`syscfg_get wl_use_hostapd`
	if [ "1" = "$USE_HOSTAPD" ] && [ "8" != "$SEC_MODE" ]; then
		configure_hostapd $PHY_IF $VIR_IF
		ret=$?
	else
		configure_user $PHY_IF $VIR_IF
		ret=$?
	fi
	unsecure_page
	
	RET_CODE="0"
	if [ "true" = "$RECONFIGURE" ]; then
		ulog wlan status "$VIR_IF is preparing to reconfigure due to incompatible mode"
		RET_CODE="2"
	else
		RET_CODE="0"
	fi
	return $RET_CODE
