	if_name=$1
	cmd_mode=$2
	FILTER_OPTION=`syscfg_get wl_access_restriction`
	MAC_ENTRIES=`syscfg_get wl_mac_filter`
	if [ "$FILTER_OPTION" = "allow" ] || [ "$FILTER_OPTION" = "deny" ]; then
		if [ "$cmd_mode" = "1" ]; then
			iwpriv $if_name set ACLClearAll=1
		fi
		MAC_LIST=""
		for MAC in $MAC_ENTRIES; do
			if [ "$cmd_mode" = "1" ]; then
				iwpriv $if_name set ACLAddEntry="$MAC"
			fi
			MAC_LIST="`echo $MAC_LIST`$MAC;"
		done
		set_wifi_val $if_name AccessControlList0 "$MAC_LIST"
		if [ "$FILTER_OPTION" = "allow" ]; then
			echo "wifi, setting mac filter to ALLOW"
			if [ "$cmd_mode" = "1" ]; then
				iwpriv $if_name set AccessPolicy=1
			fi
			set_wifi_val $if_name AccessPolicy0 1
		else
			echo "wifi, setting mac filter to DENY"
			if [ "$cmd_mode" = "1" ]; then
				iwpriv $if_name set AccessPolicy=2
			fi
			set_wifi_val $if_name AccessPolicy0 2
		fi
	else
		set_driver_mac_filter_disabled $if_name $cmd_mode
	fi
	return 0
