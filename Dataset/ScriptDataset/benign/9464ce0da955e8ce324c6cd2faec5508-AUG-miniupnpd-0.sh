#!/bin/sh

Usage()
if [ "$1" != "init" -o $# -lt 4 ]; then
	echo "Unknown command!"
	Usage
	exit 1
fi

LAN_IPADDR=$2
IF_NAME=$3
WAN_IF=$4
PORT=6352

IPTABLES=iptables
rm /etc/$MINIUPNPD_FILE 1>/dev/null 2>&1

$IPTABLES -t nat -F MINIUPNPD 1>/dev/null 2>&1
#rmeoving the rule to MINIUPNPD
$IPTABLES -t nat -D PREROUTING -i $WAN_IF -j MINIUPNPD 1>/dev/null 2>&1
$IPTABLES -t nat -X MINIUPNPD 1>/dev/null 2>&1

#removing the MINIUPNPD chain for filter
$IPTABLES -t filter -F MINIUPNPD 1>/dev/null 2>&1
#adding the rule to MINIUPNPD
$IPTABLES -t filter -D FORWARD -i $WAN_IF ! -o $WAN_IF -j MINIUPNPD 1>/dev/null 2>&1
$IPTABLES -t filter -X MINIUPNPD 1>/dev/null 2>&1


	MINIUPNPD_FILE=/etc/miniupnpd.conf

	$IPTABLES -t nat -N MINIUPNPD
	$IPTABLES -t nat -A PREROUTING -i $WAN_IF -j MINIUPNPD
	$IPTABLES -t filter -N MINIUPNPD
	$IPTABLES -t filter -A FORWARD -i $WAN_IF ! -o $WAN_IF -j MINIUPNPD

	echo "ext_ifname=$WAN_IF

listening_ip=$LAN_IPADDR

port=$PORT

bitrate_up=800000000
bitrate_down=800000000

secure_mode=no

system_uptime=yes

notify_interval=30

uuid=68555350-3352-3883-2883-335030522880

serial=12345678

model_number=1

enable_upnp=no

" > $MINIUPNPD_FILE

if [ $IF_NAME == "ra0" ]; then
	miniupnpd -m 1 -I ra0 -P /var/run/miniupnpd.ra0 -G -i $WAN_IF -a $LAN_IPADDR -n 7777
else
	if [ ! -f /var/run/miniupnpd.ra0 ]; then		
		miniupnpd -m 1 -I rai0 -P /var/run/miniupnpd.rai0 -G -i $WAN_IF -a $LAN_IPADDR -n 8888
	else
		miniupnpd -m 1 -I rai0 -P /var/run/miniupnpd.rai0 -i $WAN_IF -a $LAN_IPADDR -n 8888
	fi
fi
