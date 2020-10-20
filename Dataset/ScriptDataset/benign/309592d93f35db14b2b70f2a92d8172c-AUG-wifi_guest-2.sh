	IF_NAME=$1
	CUR_SET=`syscfg get wl_access_restriction`
	MAC_ENTRIES=`syscfg get wl_mac_filter`
	if [ "$CUR_SET" = "allow" ] || [ "$CUR_SET" = "deny" ]; then
		if [ "$CUR_SET" = "allow" ]; then
			iwpriv $IF_NAME filter 1
		else
			iwpriv $IF_NAME filter 2
		fi
		for mac in $MAC_ENTRIES; do
			macstring=`echo $mac | awk -F":" '{print $1$2$3$4$5$6}'`
			iwpriv $IF_NAME filtermac "add $macstring"
		done
	else
		iwpriv $IF_NAME filter 0
		iwpriv $IF_NAME filtermac "deleteall"
	fi
	return 0
