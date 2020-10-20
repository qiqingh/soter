	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	if [ "$WL_SYSCFG" = "wl0" ]; then
		TC_IFNAME=`syscfg_get tc_vap_user_vap`
		TC_MAC_NEW=`syscfg_get "$WL_SYSCFG".2_mac_addr`
		if [ ! -z "$TC_IFNAME" ] && [ ! -z "$TC_MAC_NEW" ]; then
			TC_MAC=`echo $TC_MAC_NEW | tr -d :`
		fi
	fi
