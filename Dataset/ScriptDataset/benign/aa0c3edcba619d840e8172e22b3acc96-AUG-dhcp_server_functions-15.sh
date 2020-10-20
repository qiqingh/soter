   GUEST_DHCP_LEASE_TIME=`syscfg get guest_dhcp_lease_time`
   GUEST_LAN_IPADDR=`syscfg get guest_lan_ipaddr`
   GUEST_LAN_NETMASK=`syscfg get guest_lan_netmask`
   CONNECTOR_GUEST_IP=`syscfg get guest_connector_lan_ipaddr`
   if [ -z "$GUEST_DHCP_LEASE_TIME" ]; then
      GUEST_DHCP_LEASE_TIME=3600
   fi
   if [ -n "$DHCP_LEASE_TIME" ] && [ $DHCP_LEASE_TIME -lt $GUEST_DHCP_LEASE_TIME ]; then
      GUEST_DHCP_LEASE_TIME=$DHCP_LEASE_TIME
   fi
   calculate_guest_dhcp_range
   echo "interface=$SYSCFG_guest_lan_ifname" >> $LOCAL_DHCP_CONF
   echo "dhcp-range=net:$SYSCFG_guest_lan_ifname,$GUEST_DHCP_START_ADDR,$GUEST_DHCP_END_ADDR,$GUEST_LAN_NETMASK,$GUEST_DHCP_LEASE_TIME" >> $LOCAL_DHCP_CONF
   if [ "`syscfg get bridge_mode`" != "0" ]; then
      echo "dhcp-leasefile=$DHCP_LEASE_FILE" >> $LOCAL_DHCP_CONF
      echo "dhcp-script=$DHCP_ACTION_SCRIPT" >> $LOCAL_DHCP_CONF
      echo "dhcp-lease-max=$GUEST_DHCP_NUM" >> $LOCAL_DHCP_CONF
      echo "dhcp-hostsfile=$DHCP_STATIC_HOSTS_FILE" >> $LOCAL_DHCP_CONF
      echo "dhcp-optsfile=$DHCP_OPTIONS_FILE" >> $LOCAL_DHCP_CONF
      if [ "$LOG_LEVEL" -gt 1 ] ; then
        echo "log-dhcp" >> $LOCAL_DHCP_CONF
      fi
   fi
   if [ ! -z $CONNECTOR_GUEST_IP ] && [ "" != "$CONNECTOR_GUEST_IP" ] &&
      [ "0.0.0.0" != "$CONNECTOR_GUEST_IP" ] ; then
      GUEST_GW_IP=$CONNECTOR_GUEST_IP
   else
      GUEST_GW_IP=$GUEST_LAN_IPADDR
   fi
