	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	WPS_STATE=`syscfg_get wps_user_setting`
	if [ "disabled" = "$WPS_STATE" ]; then
		return 0
	else
		STATE=`syscfg_get "$SYSCFG_INDEX"_state`
		IPADDR=`syscfg_get lan_ipaddr`
		if [ "up" = "$STATE" ]; then
			miniupnpd.sh init $IPADDR $PHY_IF eth1
			wsc_monitor $PHY_IF
		fi
	fi
