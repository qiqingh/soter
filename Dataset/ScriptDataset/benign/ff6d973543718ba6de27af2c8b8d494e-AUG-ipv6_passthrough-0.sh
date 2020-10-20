#!/bin/sh   

if [  "$#" != 1 ]; then
	echo "usage: $0 <on/off>"
	return
fi

WAN=`nvram_get 2860 wan_ifname`
LAN=`nvram_get 2860 lan_ifname`

if [ "$1" == "on" ]; then
	echo 1 > /proc/sys/net/ipv6/conf/$LAN/accept_ra        # Accept RA even when forwarding is enabled
  	echo 1 > /proc/sys/net/ipv6/conf/$LAN/accept_ra_defrtr # Accept default router (metric 1024)
   	echo 1 > /proc/sys/net/ipv6/conf/$LAN/accept_ra_pinfo  # Accept prefix information for SLAAC
   	echo 1 > /proc/sys/net/ipv6/conf/$LAN/autoconf         # Do SLAAC

	echo "ipv6_passthrough.sh: loading ipv6_passthrough.ko wan=$WAN lan=$LAN"
	modprobe ipv6_passthrough.ko wan=$WAN lan=$LAN
	echo "passthrough_wan.sh: turning on promiscuous mode for $WAN and $LAN" >> $LOG
	ifconfig $LAN promisc
	ifconfig $WAN promisc
else
	rmmod ipv6_passthrough.ko
fi

