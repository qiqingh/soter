   if [ "$3" = "dns_only" ] ; then
      PREFIX=#
   else
      PREFIX=
   fi
   DHCP_LEASE_MAX=`expr $SYSCFG_dhcp_num + $GUEST_DHCP_NUM`
   echo -n > $DHCP_STATIC_HOSTS_FILE
   calculate_lease_time
   echo -n > $LOCAL_DHCP_CONF
   echo "domain-needed" >> $LOCAL_DHCP_CONF
   echo "bogus-priv" >> $LOCAL_DHCP_CONF
   echo "resolv-file=$RESOLV_CONF" >> $LOCAL_DHCP_CONF
   echo "interface=$SYSCFG_lan_ifname" >> $LOCAL_DHCP_CONF
   echo "expand-hosts" >> $LOCAL_DHCP_CONF
   ROUTER_DNS_DOMAIN=`syscfg get router_dns_domain`
   if [ "" = "$ROUTER_DNS_DOMAIN" ] ; then
      ROUTER_DNS_DOMAIN=`sysevent get dhcp_domain`
   fi
   if [ "" != "$ROUTER_DNS_DOMAIN" ] ; then
      echo "domain=$ROUTER_DNS_DOMAIN" >> $LOCAL_DHCP_CONF
   fi
   LOG_LEVEL=`syscfg get log_level`
   if [ "" = "$LOG_LEVEL" ] ; then
       LOG_LEVEL=1
   fi
   if [ "$3" = "dns_only" ] ; then
      echo "no-dhcp-interface=$SYSCFG_lan_ifname" >> $LOCAL_DHCP_CONF
      echo "no-dhcp-interface=$SYSCFG_guest_lan_ifname" >> $LOCAL_DHCP_CONF
   fi
   echo "dhcp-leasefile=$DHCP_LEASE_FILE" >> $LOCAL_DHCP_CONF
    echo "$PREFIX""dhcp-range=interface:$SYSCFG_lan_ifname,set:$SYSCFG_lan_ifname,$DHCP_START_ADDR,$DHCP_END_ADDR,$2,$DHCP_LEASE_TIME" >> $LOCAL_DHCP_CONF
   echo "$PREFIX""dhcp-script=$DHCP_ACTION_SCRIPT" >> $LOCAL_DHCP_CONF
   echo "$PREFIX""dhcp-lease-max=$DHCP_LEASE_MAX" >> $LOCAL_DHCP_CONF
   echo "$PREFIX""dhcp-hostsfile=$DHCP_STATIC_HOSTS_FILE" >> $LOCAL_DHCP_CONF
   echo "$PREFIX""dhcp-optsfile=$DHCP_OPTIONS_FILE" >> $LOCAL_DHCP_CONF
   OUI=`syscfg get OUI`
   echo "$PREFIX""dhcp-option-force=cpewan-id,vi-encap:3561,4,\"$OUI\"" >> $LOCAL_DHCP_CONF
   Serial=`syscfg get device::serial_number`
   echo "$PREFIX""dhcp-option-force=cpewan-id,vi-encap:3561,5,\"$Serial\"" >> $LOCAL_DHCP_CONF
   Product=`syscfg get device::product_class`
   echo "$PREFIX""dhcp-option-force=cpewan-id,vi-encap:3561,6,\"$Product\"" >> $LOCAL_DHCP_CONF
   if [ "$LOG_LEVEL" -gt 1 ] ; then
      echo "$PREFIX""log-dhcp" >> $LOCAL_DHCP_CONF
   fi
   if [ "dns_only" != "$3" ] ; then
      prepare_dhcp_conf_static_hosts
      prepare_dhcp_options
      prepare_guest_dhcp_conf
      prepare_guest_dhcp_options
   fi
   prepare_well_known_dns $LOCAL_DHCP_CONF
   prepare_dns_a_from_sysevent_pool $LOCAL_DHCP_CONF
   prepare_dns_a_full_ip_from_sysevent_pool $LOCAL_DHCP_CONF
   prepare_dns_aaaa_from_sysevent_pool $LOCAL_DHCP_CONF
   prepare_dns_srv_from_sysevent_pool $LOCAL_DHCP_CONF
   prepare_dns_ptr_from_sysevent_pool $LOCAL_DHCP_CONF
   prepare_dns_txt_from_sysevent_pool $LOCAL_DHCP_CONF
   cat $LOCAL_DHCP_CONF > $DHCP_CONF
   rm -f $LOCAL_DHCP_CONF
   [ -f $LOCAL_DHCP_OPTIONS_FILE ] && (cat $LOCAL_DHCP_OPTIONS_FILE > $DHCP_OPTIONS_FILE)
   rm -f $LOCAL_DHCP_OPTIONS_FILE
