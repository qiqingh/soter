	if_name=$1
	FILTER_OPTION=`syscfg_get wl_access_restriction`
	MAC_ENTRIES=`syscfg_get wl_mac_filter`
	if [ "$FILTER_OPTION" = "allow" ] || [ "$FILTER_OPTION" = "deny" ]; then
		if [ "$FILTER_OPTION" = "allow" ]; then
			iwpriv $if_name maccmd 1
		else
			iwpriv $if_name maccmd 2
		fi
		for MAC in $MAC_ENTRIES; do
			iwpriv $if_name addmac $MAC
		done
	fi
	return 0
