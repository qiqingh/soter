   sysevent set ipv6_connection_state "ipv6 connection going up"
   clear_previous_lan_ipv6_prefix $SYSCFG_lan_ifname
   clear_previous_lan_ipv6_prefix $SYSCFG_guest_lan_ifname
   if [ "0" = "$SYSCFG_dhcpv6c_enable" ] ; then
      echo "$PID dhcpv6 client is not enabled. It will not be started by default_ipv6_wan.sh" >> $LOG 
   else
      echo "$PID default_ipv6_wan.sh starting dhcpv6 client." >> $LOG 
      sysevent set dhcpv6_client-restart
   fi
   if [ "1" -eq "$SYSCFG_router_adv_provisioning_enable" ] ; then
      if [ -d /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname} ] ; then
         echo "$SELF starting SLACC on wan." >> $LOG 
         echo 2 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/accept_ra    # Accept RA even when forwarding is enabled
         echo 1 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/accept_ra_defrtr # Accept default router (metric 1024)
         echo 1 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/accept_ra_pinfo # Accept prefix information for SLAAC
         echo 1 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/autoconf     # Do SLAAC
         if [ "1" = "$SYSCFG_wan_if_v6_forwarding" ] ; then
      		echo 1 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/forwarding     # our WAN side should be like a router
      	 else
      		echo 0 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/forwarding     # our WAN side should be like a host
      	 fi
         ADDR_OK=`get_SLAAC_addr ${SYSEVENT_current_wan_ipv6_ifname}`
         if [ "0"="$ADDR_OK" ]; then
            ulog default_ipv6_wan status "$PID SLAAC Address acquired"
            echo "$SELF got SLAAC address" >> $LOG 
         else
            echo "$SELF fail to get SLACC address" >> $LOG
            ulog default_ipv6_wan status "$PID SLAAC Address not yet acquired"
         fi
      else
         ulog default_ipv6_wan status "$PID ipv6 /proc not provisioned due to not ready"
      fi
      sysevent set ipv6_connection_state "ipv6 connection up pending provisioning"
      SYSCFG_wan_ifname=`syscfg get wan_1 ifname`
      if [ -z "$SYSCFG_wan_ifname" ] ; then
         ulog default_ipv6_wan status "$PID syscfg wan_1 ifname is not found. Assuming eth1"
         SYSCFG_wan_ifname="eth1"
      fi
      ulog default_ipv6_wan status "$PID Starting SLAAC Monitor on $SYSCFG_wan_ifname"
      exec $SLAAC_MONITOR_SCRIPT $SYSCFG_wan_ifname &
   else
      echo "$SELF SLACC on wan is not enabled. It will not be started by default_ipv6_wan.sh" >> $LOG 
      sysevent set ipv6_connection_state "ipv6 connection up without slaac"
   fi
   sysevent set ipv6_firewall-restart
   sysevent set current_ipv6_wan_state up
   sysevent set ipv6_wan-started
   sysevent set ipv6-status started
   sysevent set ipv6_firewall-restart
   sysevent set ipv6_wan_start_time `cat /proc/uptime | cut -d'.' -f1`
