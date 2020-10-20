   wait_till_end_state dns
   wait_till_end_state dhcp_server
   DHCP_STATE=`sysevent get dhcp_server-status`
   DNS_STATE=`sysevent get dns-status`
   if [ "0" = "$SYSCFG_dhcp_server_enabled" ]  
   then
      if [ "started" = "DNS_STATE" ]
      then
          return 0
      fi
   fi
   if [ "started" = "$DHCP_STATE" -a "started" = "$DNS_STATE" ] ; then
      return 0
   fi
   if [ "$DHCP_STATE" != "$DNS_STATE" ] ; then
      services_stop
      wait_till_end_state dhcp_server
      wait_till_end_state dns
   fi
   if [ "0" = "$SYSCFG_dhcp_server_enabled" ]
   then
      prepare_hostname
      prepare_dhcp_conf $SYSCFG_lan_ipaddr $SYSCFG_lan_netmask dns_only
      $SERVER -u nobody -P 4096 -C $DHCP_CONF -8 $LOG
      sysevent set dns-status started
      sysevent set reboot-status dhcp-started
      ulog dhcp_server status "$PID reboot-status:dhcp-started"
   else
      if [ -f "$DHCP_SLOW_START_1_FILE" ] ; then
         rm -f $DHCP_SLOW_START_1_FILE
      fi
      if [ -f "$DHCP_SLOW_START_2_FILE" ] ; then
         rm -f $DHCP_SLOW_START_2_FILE
      fi
      if [ -f "$DHCP_SLOW_START_3_FILE" ] ; then
         rm -f $DHCP_SLOW_START_3_FILE
      fi
      prepare_hostname
      if [ "$SYSCFG_bridge_mode" = "0" ] ; then
         prepare_dhcp_conf $SYSCFG_lan_ipaddr $SYSCFG_lan_netmask
      else
         prepare_guest_dhcp_conf
         cat $LOCAL_DHCP_CONF > $DHCP_CONF
         rm -f $LOCAL_DHCP_CONF
      fi
      sanitize_leases_file
		LOG_LEVEL=`syscfg get fw_log_level`
	  if [ "$LOG_LEVEL" = "0" ] ; then
		  DISABLE_DHCP_LOG="1";
	  else
		  DISABLE_DHCP_LOG="0";
   	  fi
        if [ -n "$SYSCFG_dhcp_nameserver_1" -a "$SYSCFG_dhcp_nameserver_1" != "0.0.0.0" ] || [ -n "$SYSCFG_dhcp_nameserver_2" -a "$SYSCFG_dhcp_nameserver_2" != "0.0.0.0" ] || [ -n "$SYSCFG_dhcp_nameserver_3" -a "$SYSCFG_dhcp_nameserver_3" != "0.0.0.0" ] ; then
            ORDER="--strict-order"
        else
            ORDER=""
        fi
        $SERVER -u nobody --dhcp-authoritative --disable_dhcp_log $DISABLE_DHCP_LOG -P 4096 -C $DHCP_CONF -8 $LOG $ORDER
      if [ "1" = "$DHCP_SLOW_START_NEEDED" -a -n "$TIME_FILE" ] ; then
         create_slow_start_file $TIME_FILE
         chmod 700 $TIME_FILE
      fi
      reset_ethernet_ports
      $PMON setproc dhcp_server $BIN $PID_FILE "/etc/init.d/service_dhcp_server.sh dhcp_server-restart"
      sysevent set dns-status started
      sysevent set dhcp_server-status started
      sleep 20
      sysevent set reboot-status dhcp-started
      ulog dhcp_server status "$PID reboot-status:dhcp-started"
   fi
