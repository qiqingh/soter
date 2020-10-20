	#Change delete wan interface from config file
	if [ -f "/var/etc/miniupnpd-ra0.conf" ]; then
		DELWANIF=`cat /var/etc/miniupnpd-ra0.conf | grep ext_ifname | cut -d '=' -f 2`
	elif [ -f "/var/etc/miniupnpd-rai0.conf" ]; then
		DELWANIF=`cat /var/etc/miniupnpd-rai0.conf | grep ext_ifname | cut -d '=' -f 2`
	else
		DELWANIF=$WANIF
	fi
        iptables -wt nat -F MINIUPNPD 1>/dev/null 2>&1
        iptables -wt nat -D PREROUTING -i $DELWANIF -j MINIUPNPD 1>/dev/null 2>&1
        iptables -wt nat -X MINIUPNPD 1>/dev/null 2>&1

        iptables -wt filter -F MINIUPNPD 1>/dev/null 2>&1
        iptables -wt filter -D FORWARD -i $DELWANIF ! -o $DELWANIF -j MINIUPNPD 1>/dev/null 2>&1
        iptables -wt filter -X MINIUPNPD 1>/dev/null 2>&1
