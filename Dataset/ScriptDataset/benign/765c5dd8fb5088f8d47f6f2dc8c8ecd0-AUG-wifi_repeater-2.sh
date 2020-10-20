	echo "${SERVICE_NAME}, prepare()"
	if [ "2.4GHz" = $STA_RADIO ]; then
		PHY_IF="wdev0"
		OPMODE=23
		STAMODE=7
	elif [ "5GHz" = $STA_RADIO ]; then
		PHY_IF="wdev1"
		OPMODE=28
		STAMODE=8
	fi
	VIR_IF=$PHY_IF"sta0"
	syscfg_set wifi_sta_phy_if $PHY_IF
	syscfg_set wifi_sta_vir_if $VIR_IF
	syscfg_commit
	ifconfig $PHY_IF down
	ifconfig $VIR_IF down
	return 0
