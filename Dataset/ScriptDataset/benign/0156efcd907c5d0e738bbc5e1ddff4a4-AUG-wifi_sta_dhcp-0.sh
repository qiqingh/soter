#!/bin/sh
SELECTED_STA_IF=`syscfg get wifi_sta_user_vap`
RESOLV_CONF="/etc/resolv.conf"
RESOLV_BAK="/etc/resolv.bak"
[ -n "$broadcast" ] && BROADCAST="broadcast $broadcast"
[ -n "$subnet" ] && NETMASK="netmask $subnet"
case "$1" in
	deconfig)
		if [ -f "$RESOLV_BAK" ]; then
			mv "$RESOLV_BAK" "$RESOLV_CONF"
		fi
		/sbin/ifconfig $interface 0.0.0.0
		;;
	renew|bound)
		/sbin/ifconfig $interface $ip $BROADCAST $NETMASK
		if [ -n "$router" ] ; then
			while route del default gw 0.0.0.0 dev $interface; do
				true
			done
			for i in $router ; do
				route add default gw $i dev $interface
			done
		fi
		[ -n "$domain" ] && echo search $domain >> $RESOLV_CONF
		for i in $dns ; do
			echo nameserver $i >> $RESOLV_CONF
		done
		;;
esac
exit 0
