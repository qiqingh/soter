	ONE_TIME=`sysevent get virtual-one-time-setting`
	if [ "$ONE_TIME" != "TRUE" ] ; then
		echo "wifi, platform_virtual_onetime_setting()"
		ulog wlan status "wifi, platform_virtual_onetime_setting()"
		GUEST_ENABLED=`syscfg get guest_enabled`
		WL0_GUEST_ENABLED=`syscfg get wl0_guest_enabled`
		WL1_GUEST_ENABLED=`syscfg get wl1_guest_enabled`
		SIMPLETAP=`syscfg get tc_vap_enabled`
		if [ "$GUEST_ENABLED" = "1" ] && [ "$WL0_GUEST_ENABLED" = "1" ]; then
			WL0_PHY_IF=`syscfg get wl0_user_vap`
			WL_SYSCFG=`get_syscfg_interface_name $WL0_PHY_IF`
			GUEST_VAP=`syscfg get ${WL_SYSCFG}_guest_vap`
			wl -i $GUEST_VAP wpa_auth 0
		fi
		if [ "$SIMPLETAP" = "1" ] ; then
			TC="tc_vap"
			TC_VAP=`syscfg get ${TC}_user_vap`
			WPA_AUTH=`syscfg get ${TC}_wpa_auth`
			wl -i $TC_VAP wpa_auth $WPA_AUTH
		fi
		if [ "$GUEST_ENABLED" = "1" ] && [ "$WL1_GUEST_ENABLED" = "1" ] ; then
			WL1_PHY_IF=`syscfg get wl1_user_vap`
			WL_SYSCFG=`get_syscfg_interface_name $WL1_PHY_IF`
			WL1_GUEST_VAP=`syscfg get ${WL_SYSCFG}_guest_vap`
			wl -i $WL1_GUEST_VAP wpa_auth 0
		fi
		sysevent set virtual-one-time-setting "TRUE"
	fi
