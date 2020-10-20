   eval `utctx_cmd get dhcpv6c_enable dhcpv6c_duid lan_ifname guest_lan_ifname`
   if [ -z "$SYSCFG_dhcpv6c_enable" ] ; then
      SYSCFG_dhcpv6c_enable=3
   fi
   SYSEVENT_current_wan_ipv6_ifname=`sysevent get current_wan_ipv6_ifname`
   SYSEVENT_wan_ppp_ifname=`sysevent get wan_ppp_ifname`
   if [ "up" = "`sysevent get ppp_status`" ] ; then
      WAN_INTERFACE_NAME=$SYSEVENT_wan_ppp_ifname
   else
      WAN_INTERFACE_NAME=$SYSEVENT_current_wan_ipv6_ifname
   fi
