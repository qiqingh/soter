	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	if [ "disabled" = "`syscfg_get wps_user_setting`" ]; then
		return 0
	else
		STATE=`syscfg_get "$SYSCFG_INDEX"_state`
        BRIDGE_MODE=`syscfg_get bridge_mode`
		IPADDR=`syscfg_get lan_ipaddr`
        if [ "$BRIDGE_MODE" != "0" ]; then
		    IPADDR=`sysevent get ipv4_wan_ipaddr`
        fi
		if [ "up" = "$STATE" ]; then
			miniupnpd.sh init $IPADDR $PHY_IF eth1
			wsc_monitor $PHY_IF
		fi
	fi
