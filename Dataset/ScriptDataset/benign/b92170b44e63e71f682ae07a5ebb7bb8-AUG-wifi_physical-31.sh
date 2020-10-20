	PHY_IF=$1
	WLINDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	POWER=`syscfg_get "$WLINDEX"_transmission_power`
	if [ "low" = "$POWER" ]; then
		set_wifi_val $PHY_IF TxPower 33
	elif [ "medium" = "$POWER" ]; then
		set_wifi_val $PHY_IF TxPower 66
	else	#high power or default
		set_wifi_val $PHY_IF TxPower 100
	fi
	
	return 0
