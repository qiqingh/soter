	#remove_miniupnp_iptable
        json_load "$(objReq upnp json)"
        json_select UpnpP
        json_get_var enable enable
	json_get_var USERCONF allowUserConf
	json_get_var USERDISCONNECT disableInternet

	json_load "$(objReq wan json)"
	json_select WanP
	json_get_var wanmode proto
	if [ "$wanmode" = "$WAN_PROTO_L2TP" ]; then
		WANIF="l2tp-vpn"
	elif [ "$wanmode" = "$WAN_PROTO_PPTP" ]; then
		WANIF="pptp-vpn"
	elif [ "$wanmode" = "$WAN_PROTO_PPPOE" ]; then
		WANIF="pppoe-wan"
	fi

	OPGID=""
	[ $enable == "1" ] && { OPGID="-G"; }

	if [ $wanmode = "$WAN_PROTO_BRIDGE" -o $wanmode = "$WAN_PROTO_WLAN_BRIDGE" ]; then
		echo "Start miniupnpd bridge" > /dev/console
		setup_miniupnp_conf bridge
		network_get_ipaddr lanIp lan
		miniupnpd -m 1 -I ra0 -f "/var/etc/miniupnpd-ra0.conf" -P "/var/run/miniupnpd.ra0" $OPGID -i br-lan -a $lanIp -n 7922
		miniupnpd -m 1 -I rai0 -f "/var/etc/miniupnpd-rai0.conf" -P "/var/run/miniupnpd.rai0" $OPGID -i br-lan -a $lanIp -n 7930
	else
		#[ -n "$OPGID" ] && { setup_miniupnp_iptable; }
		if [ -z $1 ]; then
			echo "Start miniupnpd all" > /dev/console
			setup_miniupnp_conf
			miniupnpd -m 1 -I ra0 -f "/var/etc/miniupnpd-ra0.conf" -P "/var/run/miniupnpd.ra0" $OPGID -i $WANIF -a "$LANIP/$LANMASK" -n 7922
			miniupnpd -m 1 -I rai0 -f "/var/etc/miniupnpd-rai0.conf" -P "/var/run/miniupnpd.rai0" $OPGID -i $WANIF -a "$LANIP/$LANMASK" -n 7930
		else
			[ $1 == "ra0" ] && { PORT="7922"; }
			[ $1 == "rai0" ] && { PORT="7930"; }
			echo "Start miniupnpd $1" > /dev/console
			setup_miniupnp_conf $1
			miniupnpd -m 1 -I $1 -f "/var/etc/miniupnpd-$1.conf" -P "/var/run/miniupnpd.$1" $OPGID -i $WANIF -a "$LANIP/$LANMASK" -n $PORT
		fi
	fi
