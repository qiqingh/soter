   wait_till_end_state dns
   wait_till_end_state dhcp_server
   CURRENT_LAN_STATE=$1
   ulog dhcp_server status "$PID got event lan-status: $CURRENT_LAN_STATE"
   if [ "stopped" = "$CURRENT_LAN_STATE" ] ; then
      services_stop
   elif [ "started" = "$CURRENT_LAN_STATE" ] ; then
      DHCP_STATE=`sysevent get dhcp_server-status`
      DNS_STATE=`sysevent get dns-status`
      if [ "0" = "$SYSCFG_dhcp_server_enabled" -a "stopped" != "$DHCP_STATE" ] ; then
         services_stop
         wait_till_end_state dns
         wait_till_end_state dhcp_server
      fi
      if [ "0" != "$SYSCFG_dhcp_server_enabled" -a "started" != "$DHCP_STATE" ] ; then
         services_start
      elif [ "started" != "$DNS_STATE" ] ; then
         services_start
      fi
   fi
