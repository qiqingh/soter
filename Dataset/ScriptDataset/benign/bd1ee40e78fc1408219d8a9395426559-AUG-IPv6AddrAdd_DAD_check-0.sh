#!/bin/sh
#############################################################################################
# exit 1: input parameter error
# exit 0: No DAD
# exit 3: DAD detected
#############################################################################################
# NOTE:	$new_ip6_address, $new_ip6_prefixlen and $interface are shell environment variables
#		which pass by caller execve()
#############################################################################################

if [ -z "$new_ip6_address" ]; then
#	echo "<$0> IPv6 addr is empty"
	exit 1
fi

if [ -z "$new_ip6_prefixlen" ]; then
#	echo "<$0> IPv6 prefix length is empty"
	exit 1
fi

if [ -z "$interface" ]; then
#	echo "<$0> interface name is empty"
	exit 1
fi

#echo "<$0> new_ip6_address=$new_ip6_address, new_ip6_prefixlen=$new_ip6_prefixlen, interface=$interface"

ip -6 addr add $new_ip6_address/$new_ip6_prefixlen dev $interface scope global 2>/dev/null

#############################################################
# repeatedly test whether newly added address passed
# duplicate address detection (DAD)
#############################################################
COUNT_LIST="1 2 3 4 5"

for i in $COUNT_LIST
do
#	echo "<$0> retryCount: $retryCount"
#	echo "<$0> COUNT_LIST: $i"
	sleep 1 # give the DAD some time

	#############################################################
	# tentative flag = DAD is still not complete or failed
	#############################################################
	duplicate=`ip -6 addr show dev $interface tentative  | grep $new_ip6_address/$new_ip6_prefixlen`

	#############################################################
	# if there's no tentative flag, address passed DAD
	#############################################################
	if [ -z "$duplicate" ]; then
#		echo "<$0> IPv6 addr Not duplicated"
		exit 0
	fi
done

#echo "<$0> IPv6 addr Duplicated"
ip -6 addr del $new_ip6_address/$new_ip6_prefixlen dev $interface 2>/dev/null
exit 3

