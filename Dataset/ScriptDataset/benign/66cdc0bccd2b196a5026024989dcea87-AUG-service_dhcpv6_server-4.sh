   eval `utctx_cmd get dhcpv6s_duid lan_ifname dhcpv6s_enable dhcp_server_propagate_wan_nameserver`
   LAN_INTERFACE_NAME=$SYSCFG_lan_ifname
   LAN_STATE=`sysevent get lan-status`
   DHCPV6_BINARY=/sbin/dhcp6s
   DHCPV6_CONF_FILE=/etc/dhcp6s.conf
   DHCPV6_PID_FILE=/var/run/dhcp6s.pid
