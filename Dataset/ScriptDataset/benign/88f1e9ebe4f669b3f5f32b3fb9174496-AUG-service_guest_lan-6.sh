	V_IF=$1
	get_syscfg_interface_index $V_IF
	WL_INDEX=$?
	GUEST_IF=`syscfg get wl"$WL_INDEX"_guest_vap`
	GUEST_SSID=`syscfg get wl"$WL_INDEX"_guest_ssid`
	if [ -z $GUEST_SSID ]; then 
		ulog wlan status "User VAP ssid  wl$WL_INDEX is empty"
		return 1
	fi
        wl -i $GUEST_IF down
	wl -i $V_IF bss -C 0 down
	wl -i $V_IF bss -C 1 down
	
	setup_vap_opensecurity $GUEST_IF
	return $RET
