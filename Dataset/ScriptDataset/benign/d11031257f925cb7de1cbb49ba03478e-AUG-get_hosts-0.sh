#!/bin/sh

. /usr/share/libubox/jshn.sh
. /lib/functions/network.sh


IP4_NEIGH_FILE="/tmp/.ip4_neigh"
OLD_HOSTS_FILE="/tmp/.old_hosts"
NEW_HOSTS_FILE="/tmp/.new_hosts"

true > $IP4_NEIGH_FILE
true > $OLD_HOSTS_FILE
true > $NEW_HOSTS_FILE

ip -4 neigh show dev br-lan > $IP4_NEIGH_FILE

handle_old_hosts
handle_dhcp_hosts
handle_static_hosts
handle_new_hosts
cat $NEW_HOSTS_FILE

