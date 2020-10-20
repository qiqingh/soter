#!/bin/sh
DHCP_CONF=/etc/dnsmasq.conf
DHCP_STATIC_HOSTS_FILE=/etc/dhcp_static_hosts
DHCP_OPTIONS_FILE=/etc/dhcp_options
LOCAL_DHCP_CONF=/tmp/dnsmasq.conf$$
LOCAL_DHCP_STATIC_HOSTS_FILE=/tmp/dhcp_static_hosts$$
LOCAL_DHCP_OPTIONS_FILE=/tmp/dhcp_options$$
RESOLV_CONF=/etc/resolv.conf
LOG_FILE=/tmp/udhcp.log
SLOW_START_NUM_TRIES_1=6
SLOW_START_NUM_TRIES_2=8
SLOW_START_NUM_TRIES_3=10
SYSCFG_lan_ifname=`syscfg get lan_ifname`
SYSCFG_guest_lan_ifname=`syscfg get guest_lan_ifname`
SYSCFG_guest_enabled=`syscfg get guest_enabled`
SYSCFG_User_Accepts_WiFi_Is_Unsecure=`syscfg get User_Accepts_WiFi_Is_Unsecure`
DHCP_LEASE_FILE=/etc/dnsmasq.leases
DHCP_ACTION_SCRIPT=/etc/init.d/service_dhcp_server/dnsmasq_dhcp.script
CLOUD_DNS_NAMES_FILE=/etc/cloud_dns_names
SYSEVENT_lan_ipaddr=`sysevent get lan_ipaddr`
SYSEVENT_lan_prefix_len=`sysevent get lan_prefix_len`
if [ -n "${SYSEVENT_lan_ipaddr}" ] ; then
    eval `ipcalc -n ${SYSEVENT_lan_ipaddr}/${SYSEVENT_lan_prefix_len}`
fi
LAN_NETWORK=$NETWORK
SYSCFG_dhcp_num=`syscfg get dhcp_num`
if [ "" = "$SYSCFG_dhcp_num" ] ; then
   SYSCFG_dhcp_num=0
fi
SYSCFG_dhcp_start=`syscfg get dhcp_start`
SYSCFG_dhcp_end=`syscfg get dhcp_end`
if [ -z "$SYSCFG_dhcp_end" ] ; then
   SYSCFG_dhcp_end=`dc $SYSCFG_dhcp_start $SYSCFG_dhcp_num + 1 - p`
fi
make_ip_using_subnet $LAN_NETWORK $SYSEVENT_lan_prefix_len $SYSCFG_dhcp_start
DHCP_START_ADDR=$CREATED_IP_ADDRESS
make_ip_using_subnet $LAN_NETWORK $SYSEVENT_lan_prefix_len $SYSCFG_dhcp_end
DHCP_END_ADDR=$CREATED_IP_ADDRESS
GUEST_MAX_ALLOWED_LIMIT=`syscfg get guest_max_allowed_limit`
GUEST_DHCP_NUM=`expr $GUEST_MAX_ALLOWED_LIMIT + 10`
