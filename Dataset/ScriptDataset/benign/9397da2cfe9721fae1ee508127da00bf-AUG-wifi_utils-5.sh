	return
	if [ "up" = "`syscfg_get wl0_state`" ]; then
		if [ "1" = "`syscfg_get wl0_guest_enabled`" ] && [ "1" = "`syscfg_get guest_enabled`" ]; then
			sleep 2
		fi
	fi
	if [ "up" = "`syscfg_get wl1_state`" ]; then
		if [ "1" = "`syscfg_get wl1_guest_enabled`" ] && [ "1" = "`syscfg_get guest_enabled`" ]; then
			sleep 2
		fi
	fi
