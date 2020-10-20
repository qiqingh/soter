   sysevent set ${SERVICE_NAME}-status starting
   sysevent set ${SERVICE_NAME}-errinfo
   ulog ipv6 status "$PID bringing ipv6 wan up"
   if [ -z "$IPV6_WAN_PROTO" ] ; then
     sysevent set ${SERVICE_NAME}-status error
     sysevent set ${SERVICE_NAME}-errinfo "No ipv6 proto specified on wan"
   fi
   sysevent set dhcpv6_client_current_config
   WAN_IFNAME=`sysevent get current_wan_ifname`
   if [ "dslite" = "$WAN_IFNAME" ] ; then
      SYSCFG_hardware_vendor_name=`syscfg get hardware_vendor_name`
      if [ -n "$SYSCFG_hardware_vendor_name" -a "Broadcom" = "$SYSCFG_hardware_vendor_name" ] ; then
         SYSCFG_wan_virtual_ifnum=`syscfg get wan_virtual_ifnum`
         WAN_IFNAME="vlan${SYSCFG_wan_virtual_ifnum}"
      else
         SYSCFG_ifname=`syscfg get wan_physical_ifname`
         WAN_IFNAME="${SYSCFG_ifname}"
      fi
   fi
   if [ -z "$WAN_IFNAME" ] ; then
      WAN_IFNAME=`syscfg get wan_1 ifname`
   fi
   if [ -z "$WAN_IFNAME" ] ; then
      WAN_IFNAME=`syscfg get lan_ifname`
   fi
   
   if [ "0" = "$SYSCFG_6rd_enable" ] ; then
      sysevent set current_wan_ipv6_ifname $WAN_IFNAME 
   else
      sysevent set current_wan_ipv6_ifname tun6rd 
   fi
   unregister_ipv6_handlers
   register_ipv6_handlers
   sysevent set ipv6_connection_state "starting ipv6"
   ulog ipv6 status "$PID setting desired_ipv6_link_state up"
   sysevent set desired_ipv6_link_state up
   ulog ipv6 status "$PID setting desired_ipv6_wan_state up"
   sysevent set desired_ipv6_wan_state up
