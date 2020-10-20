	INTF_24=`syscfg get wl0_user_vap`
	INTF_24_GUEST=`syscfg get wl0_guest_vap`
	INTF_5L=`syscfg get wl1_user_vap`
	INTF_5L_GUEST=`syscfg get wl1_guest_vap`
	if [ "up" = "`syscfg get wl0_state`" ]; then
		iwpriv $INTF_24 set DisConnectAllSta=1
		sleep 2
		if [ "1" = "`syscfg get wl0_guest_enabled`" ] && [ "1" = "`syscfg get guest_enabled`" ]; then
			iwpriv $INTF_24_GUEST set DisConnectAllSta=1
			sleep 2
		fi
	fi
	if [ "up" = "`syscfg get wl1_state`" ]; then
		iwpriv $INTF_5L set DisConnectAllSta=1
		sleep 2
		if [ "1" = "`syscfg get wl1_guest_enabled`" ] && [ "1" = "`syscfg get guest_enabled`" ]; then
			iwpriv $INTF_5L_GUEST set DisConnectAllSta=1
			sleep 2
		fi
	fi
