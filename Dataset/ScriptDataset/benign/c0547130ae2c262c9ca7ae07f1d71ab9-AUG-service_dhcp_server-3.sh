   CURRENT_LAN_STATE=`sysevent get lan-status`
   if [ "started" != "$CURRENT_LAN_STATE" ] ; then
      exit 0
   fi
   wait_till_end_state dns
   wait_till_end_state dhcp_server
   DHCP_TMP_CONF="/tmp/dnsmasq.conf.orig"
   cp -f $DHCP_CONF $DHCP_TMP_CONF
   if [ "0" = "$SYSCFG_dhcp_server_enabled" ] ; then
      prepare_hostname
      prepare_dhcp_conf $SYSCFG_lan_ipaddr $SYSCFG_lan_netmask dns_only
   else
      prepare_hostname
      prepare_dhcp_conf $SYSCFG_lan_ipaddr $SYSCFG_lan_netmask
      sanitize_leases_file
   fi
   RESTART=0
   diff -q $DHCP_CONF $DHCP_TMP_CONF
   if [ "0" != "$?" ] ; then
      RESTART=1
   fi
   CURRENT_PID=`cat $PID_FILE`
   if [ -z "$CURRENT_PID" ] ; then
      RESTART=1
   else
      CURRENT_PIDS=`pidof dnsmasq`
      if [ -z "$CURRENT_PIDS" ] ; then
         RESTART=1
      else
         RUNNING_PIDS=`pidof dnsmasq`
         FOO=`echo $RUNNING_PIDS | grep $CURRENT_PID`
         if [ -z "$FOO" ] ; then
            RESTART=1
         fi
      fi 
   fi
   rm -f $DHCP_TMP_CONF
   killall -HUP `basename $SERVER`
   if [ "0" = "$RESTART" ] ; then
      reset_ethernet_ports
      sysevent set reboot-status dhcp-started
      if [ "$EVENT" = "dns-restart" ];then
          sysevent set eth-status power-cycled
      fi
      ulog dhcp_server status "$PID reboot-status:dhcp-started, dhcp-server no need restart"
      exit 0
   else
      services_stop
      services_start
   fi
