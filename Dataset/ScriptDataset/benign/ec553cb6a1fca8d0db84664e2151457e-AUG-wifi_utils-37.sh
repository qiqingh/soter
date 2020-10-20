	if [ "up" = "`syscfg get wl0_state`" ]; then
		INTF_24=`syscfg get wl0_user_vap`
		INTF_24_GUEST=`syscfg get wl0_guest_vap`
		if [ "1" = "`syscfg get wl0_guest_enabled`" ] && [ "1" = "`syscfg get guest_enabled`" ]; then
			wl -i $INTF_24_GUEST down
		fi
		wl -i $INTF_24 down
		sleep 2
		wl -i $INTF_24 up
		sleep 1
		if [ "1" = "`syscfg get wl0_guest_enabled`" ] && [ "1" = "`syscfg get guest_enabled`" ]; then
			wl -i $INTF_24_GUEST up
			sleep 1
		fi
	fi
	if [ "up" = "`syscfg get wl1_state`" ]; then
		INTF_5L=`syscfg get wl1_user_vap`
		INTF_5L_GUEST=`syscfg get wl1_guest_vap`
		if [ "1" = "`syscfg get wl1_guest_enabled`" ] && [ "1" = "`syscfg get guest_enabled`" ]; then
			wl -i $INTF_5L_GUEST down
		fi
		wl -i $INTF_5L down
		sleep 2
		wl -i $INTF_5L up
		sleep 1
		if [ "1" = "`syscfg get wl1_guest_enabled`" ] && [ "1" = "`syscfg get guest_enabled`" ]; then
			wl -i $INTF_5L_GUEST up
			sleep 1
		fi
	fi
	if [ "up" = "`syscfg get wl2_state`" ]; then
		INTF_5U=`syscfg get wl2_user_vap`
		wl -i $INTF_5U down
		sleep 2
		wl -i $INTF_5U up
		sleep 1
	fi
