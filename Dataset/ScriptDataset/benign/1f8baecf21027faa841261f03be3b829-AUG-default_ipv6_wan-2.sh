   SLAAC_PID_FILE="/var/run/slaac_monitor.pid"
   if [ -f "$SLAAC_PID_FILE" ] ; then
      kill  `cat $SLAAC_PID_FILE`
      rm -f $SLAAC_PID_FILE
      ulog default_ipv6_wan status "$PID killing SLAAC Monitor"
      OWNER=`sysevent get current_wan_ipv6address_owner`
      if [ "$OWNER" = "slaac" ] ; then
         sysevent set current_wan_ipv6address
         sysevent set current_wan_ipv6address_owner
         sysevent set preferred_time_slaac
      fi
   fi
   sysevent set ipv6_connection_state "ipv6 connection going down"
   sysevent set ipv6-errinfo
   sysevent set ipv6-status stopping
   sysevent set dhcpv6_client-stop
   sleep 2
   if [ -d /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname} ] ; then
      echo 0 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/accept_ra    # Never accept RA
      echo 0 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/accept_ra_defrtr # Accept default router (metric 1024)
      echo 0 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/accept_ra_pinfo # Accept prefix information for SLAAC
      echo 0 > /proc/sys/net/ipv6/conf/${SYSEVENT_current_wan_ipv6_ifname}/autoconf     # Do SLAAC
      ulog default_ipv6_wan status "$PID setting current_ipv6_wan_state down"
   fi
   sysevent set ipv6_wan-stopped
   if [ "slaac" = "`sysevent get current_wan_ipv6address_owner`" ] ; then
      sysevent set current_wan_ipv6address
      sysevent set current_wan_ipv6address_owner
   fi
   save_lan_ipv6_prefix $SYSCFG_lan_ifname
   save_lan_ipv6_prefix $SYSCFG_guest_lan_ifname
   sysevent set current_ipv6_wan_state down
   sysevent set ipv6-status stopped
   sysevent set ipv6_firewall-restart
   sysevent set radvd-reload
   sysevent set ipv6_connection_state "ipv6 connection down"
