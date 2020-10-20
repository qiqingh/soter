   sysevent set ipv6_connection_state "ipv6 connection going up"
   if [ -z "$SYSCFG_wan_ipv6addr" -o -z "$SYSCFG_wan_ipv6_default_gateway" ] ; then
      ulog default_ipv6_wan status "Incomplete provisioning for static ipv6 ($SYSCFG_wan_ipv6addr, $SYSCFG_wan_ipv6_default_gateway)"
      ulog default_ipv6_wan status "Attempting SLAAC provisioning"
      sysevent set ipv6_connection_state "ipv6 static provisioning problem"
      sysevent set ipv6_connection_state "ipv6 connection up statically"
   else
      echo "$SELF `date +%X`: ip -6 addr add $SYSCFG_wan_ipv6addr dev $SYSEVENT_current_wan_ipv6_ifname" >> $LOG 2>&1
      ip -6 addr add $SYSCFG_wan_ipv6addr dev $SYSEVENT_current_wan_ipv6_ifname >> $LOG 2>&1
      CURRENT_OWNER=`sysevent get current_wan_ipv6address_owner`
      if [ -z "$CURRENT_OWNER" -o "static" = "$CURRENT_OWNER"  ] ; then
         CHOPPED_ADDR=`echo $SYSCFG_wan_ipv6addr | cut -d'/' -f1`
         sysevent set current_wan_ipv6address $CHOPPED_ADDR
      fi
      echo "$SELF `date +%X`: ip -6 route add default via $SYSCFG_wan_ipv6_default_gateway dev $SYSEVENT_current_wan_ipv6_ifname" >> $LOG 2>&1
      ip -6 route add default via $SYSCFG_wan_ipv6_default_gateway dev $SYSEVENT_current_wan_ipv6_ifname >> $LOG 2>&1
      sysevent set ipv6_connection_state "static addressing"
   fi
   if [ "1" -eq "$SYSCFG_router_adv_provisioning_enable" ] ; then
      echo "$PID static_ipv6_wan.sh starting SLACC on wan." >> $LOG 
      echo 2 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/accept_ra    # Accept RA even when forwarding is enabled
      echo 1 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/accept_ra_defrtr # Accept default router (metric 1024)
      echo 1 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/accept_ra_pinfo # Accept prefix information for SLAAC
      echo 1 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/autoconf     # Do SLAAC
      if [ "1" = "$SYSCFG_wan_if_v6_forwarding" ] ; then
      	echo 1 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/forwarding     # our WAN side should be like a router
      else
      	echo 0 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/forwarding     # our WAN side should be like a host
      fi
   else
      echo "$PID SLACC on wan is not enabled. It will not be started by static_ipv6_wan.sh" >> $LOG 
   fi
   sysevent set ipv6_firewall-restart
   sysevent set current_ipv6_wan_state up
   sysevent set ipv6_wan-started
   sysevent set ipv6-status started
   sysevent set ipv6_firewall-restart
   sysevent set ipv6_wan_start_time `cat /proc/uptime | cut -d'.' -f1`
