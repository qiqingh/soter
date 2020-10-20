	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	if [ "$WL_SYSCFG" = "wl0" ]; then
		GUEST_IFNAME=`syscfg_get wl0_guest_vap`
		GUEST_MAC_NEW=`syscfg_get "$WL_SYSCFG".1_mac_addr`
		if [ ! -z "$GUEST_IFNAME" ] && [ ! -z "$GUEST_MAC_NEW" ]; then
			GUEST_MAC=`echo $GUEST_MAC_NEW | tr -d :`
		fi
	fi
