#!/bin/sh
echo [$0] ... > /dev/console

case "$1" in
set)
	case "$2" in
	static)
		if [ "$3" = "" ] || [ "$4" = "" ]; then
			echo "usage: cloud_lan.sh set static <IP> <netmask> <gateway> <Primary DNS server> <Secondary DNS server>"
	            exit
	        fi
		rgdb -s /wan/rg/inf:1/mode 1
		rgdb -s /wan/rg/inf:1/static/ip "$3"
		rgdb -s /wan/rg/inf:1/static/netmask "$4"
		rgdb -s /wan/rg/inf:1/static/gateway "$5"
		rgdb -s /dnsRelay/server/primarydns "$6"
		rgdb -s /dnsRelay/server/secondarydns "$7"
		/etc/scripts/misc/profile.sh put
		;;
	dynamic)
		rgdb -s /wan/rg/inf:1/mode 2
		rgdb -s /dnsRelay/server/primarydns ""
		rgdb -s /dnsRelay/server/secondarydns ""
		/etc/scripts/misc/profile.sh put
		;;
	*)
		echo "usage: cloud_lan.sh set {static|dynamic}"
		;;
	esac
	;;
get)
	if [ "`rgdb -i -g /wan/rg/inf:1/mode`" = "1" ]; then
		echo "Static mode"
		echo "IP address: `rgdb -i -g /wan/rg/inf:1/static/ip`"
		echo "Netmask: `rgdb -i -g /wan/rg/inf:1/static/netmask`"
		echo "Gateway: `rgdb -i -g /wan/rg/inf:1/static/gateway`"
		echo "Primary DNS: `rgdb -i -g /dnsRelay/server/primarydns`"
		echo "Secondary DNS: `rgdb -i -g /dnsRelay/server/secondarydns`"
	else
		echo "Dynamic mode"
		echo "IP address: `rgdb -i -g /runtime/wan/inf:1/ip`"
		echo "Netmask: `rgdb -i -g /runtime/wan/inf:1/netmask`"
		echo "Gateway: `rgdb -i -g /runtime/wan/inf:1/gateway`"
		echo "Primary DNS: `rgdb -i -g /runtime/wan/inf:1/primarydns`"
		echo "Secondary DNS: `rgdb -i -g /runtime/wan/inf:1/secondarydns`"
	fi
	;;
*)
	echo "usage: cloud_lan.sh {set} {static|dynamic}"
	echo "cloud_lan.sh {get}"
	;;
esac
