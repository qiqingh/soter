#!/bin/sh
## $1 == 0 => enable Ipv6
## $1 == 1 => disable Ipv6
IPv6ProcPath="/proc/sys/net/ipv6/conf/"
IntName=`ls /proc/sys/net/ipv6/conf/`
for i in $IntName
do
	echo $1 > /proc/sys/net/ipv6/conf/$i/disable_ipv6
	###### DBG 
	#echo "/proc/sys/net/ipv6/conf/$i/disable_ipv6=`cat /proc/sys/net/ipv6/conf/$i/disable_ipv6`"
done
