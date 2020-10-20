	ONE_TIME=`sysevent get virtual-one-time-setting`
	if [ "$ONE_TIME" != "TRUE" ] ; then
		GUEST=`syscfg get guest_enabled`
		SIMPLETAP=`syscfg get tc_vap_enabled`
		if [ "$GUEST" = "1" ] || [ "$SIMPLETAP" = "1" ] ; then
			ulog wlan status "wifi, platform_virtual_onetime_setting()"
			TC="tc_vap"
			TC_VAP=`syscfg get ${TC}_user_vap`
			WPA_AUTH=`syscfg get ${TC}_wpa_auth`
			USER_VAP=`syscfg get wl0_user_vap`
			WL_SYSCFG=`get_syscfg_interface_name $USER_VAP`
			GUEST_VAP=`syscfg get ${WL_SYSCFG}_guest_vap`
			wl -i $GUEST_VAP wpa_auth 0
			wl -i $TC_VAP wpa_auth $WPA_AUTH
			sysevent set virtual-one-time-setting "TRUE"
		fi
	fi
