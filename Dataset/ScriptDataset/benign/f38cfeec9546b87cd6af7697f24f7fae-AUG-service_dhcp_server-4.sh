   wait_till_end_state dhcp_server
   DHCP_STATUS=`sysevent get dhcp_server-status`
   if [ "stopped" = "$DHCP_STATUS" ] ; then
      return 0
   fi
   services_stop
   wait_till_end_state dns
   prepare_hostname
   prepare_dhcp_conf $SYSCFG_lan_ipaddr $SYSCFG_lan_netmask dns_only
   $SERVER -u nobody -P 4096 -C $DHCP_CONF -8 $LOG
   sysevent set dns-status started
