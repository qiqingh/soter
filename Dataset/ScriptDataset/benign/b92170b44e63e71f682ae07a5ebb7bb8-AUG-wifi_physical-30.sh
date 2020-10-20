	PHY_IF=$1
	WLINDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	RATE=`syscfg_get "$WLINDEX"_n_transmission_rate`
	if [ "0" ]; then
		set_wifi_val $PHY_IF HT_MCS 33
	elif [ "6.5" ]; then
		set_wifi_val $PHY_IF HT_MCS 0
	elif [ "13" ]; then
		set_wifi_val $PHY_IF HT_MCS 8
	elif [ "19.5" ]; then
		set_wifi_val $PHY_IF HT_MCS 2
	elif [ "26" ]; then
		set_wifi_val $PHY_IF HT_MCS 9
	elif [ "39" ]; then
		set_wifi_val $PHY_IF HT_MCS 10
	elif [ "52" ]; then
		set_wifi_val $PHY_IF HT_MCS 11
	elif [ "58.5" ]; then
		set_wifi_val $PHY_IF HT_MCS 6
	elif [ "65" ]; then
		set_wifi_val $PHY_IF HT_MCS 7
	elif [ "78" ]; then
		set_wifi_val $PHY_IF HT_MCS 12
	elif [ "104" ]; then
		set_wifi_val $PHY_IF HT_MCS 13
	elif [ "117" ]; then
		set_wifi_val $PHY_IF HT_MCS 14
	elif [ "130" ]; then
		set_wifi_val $PHY_IF HT_MCS 15
	else	#if unset, make auto
		set_wifi_val $PHY_IF HT_MCS 33
	fi
	
	return 0
