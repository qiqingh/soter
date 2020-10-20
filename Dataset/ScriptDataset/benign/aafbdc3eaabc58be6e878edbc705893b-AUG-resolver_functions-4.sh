   eval `utctx_cmd get wan_proto router_dns_domain bridge_mode bridge_ipaddr bridge_netmask bridge_default_gateway bridge_nameserver1 bridge_nameserver2 bridge_nameserver3 bridge_domain nameserver1 nameserver2 nameserver3 ipv6_enable ipv6_domain dhcp_server_propagate_wan_nameserver`
   SYSEVENT_dhcp_domain=`sysevent get dhcp_domain`
   SYSEVENT_ipv6_domain=`sysevent get ipv6_domain`
   SYSEVENT_wan_dynamic_dns=`sysevent get wan_dynamic_dns`
   SYSEVENT_ipv6_nameserver=`sysevent get ipv6_nameserver`
   SYSEVENT_wan_ppp_dns=`sysevent get wan_ppp_dns`
   REAL_RESOLV_CONF="/etc/resolv.conf"
   TEMP_RESOLV_CONF="/tmp/resolv.conf.$$"
   echo -n  > $TEMP_RESOLV_CONF
   if [ "1" = "$SYSCFG_bridge_mode" -o "2" = "$SYSCFG_bridge_mode" ] ; then
      if [ "2" = "$SYSCFG_bridge_mode" ] ; then
         if [ -n "$SYSCFG_bridge_ipaddr" -a -n "$SYSCFG_bridge_netmask" -a -n "$SYSCFG_bridge_default_gateway" ] ; then
            if [ -n "$SYSCFG_bridge_domain" ] ; then
               echo "search $SYSCFG_bridge_domain" >> $TEMP_RESOLV_CONF
            fi
            if [ -n "$SYSCFG_bridge_nameserver1" ]  && [ "0.0.0.0" !=  "$SYSCFG_bridge_nameserver1" ] ; then
               echo "nameserver $SYSCFG_bridge_nameserver1" >> $TEMP_RESOLV_CONF
            fi
            if [ -n "$SYSCFG_bridge_nameserver2" ]  && [ "0.0.0.0" !=  "$SYSCFG_bridge_nameserver2" ] ; then
               echo "nameserver $SYSCFG_bridge_nameserver2" >> $TEMP_RESOLV_CONF
            fi
            if [ -n "$SYSCFG_bridge_nameserver3" ]  && [ "0.0.0.0" !=  "$SYSCFG_bridge_nameserver3" ] ; then
               echo "nameserver $SYSCFG_bridge_nameserver3" >> $TEMP_RESOLV_CONF
            fi
         else 
            echo "incorrect provisioning for bridge mode static $SYSCFG_bridge_ipaddr,$SYSCFG_bridge_netmask,$SYSCFG_bridge_default_gateway." > /dev/console
         fi
      else
         if [ -n "$SYSEVENT_dhcp_domain" ] ; then
            echo "search $SYSEVENT_dhcp_domain" >> $TEMP_RESOLV_CONF
         fi
         for i in $SYSEVENT_wan_dynamic_dns ; do
            echo nameserver $i >> $TEMP_RESOLV_CONF
         done
      fi
   else
      if [ -n "$SYSEVENT_dhcp_domain" ] ; then
         echo "search $SYSEVENT_dhcp_domain" >> $TEMP_RESOLV_CONF
      fi
      echo "nameserver 127.0.0.1" >> $TEMP_RESOLV_CONF
      add_statically_provisioned_nameservers
      if [ "static" = "$SYSCFG_wan_proto" ] ; then
         if [ "" != "$SYSCFG_router_dns_domain" ] ; then
            echo "search $SYSCFG_router_dns_domain" >> $TEMP_RESOLV_CONF
         fi
         echo "nameserver 127.0.0.1" >> $TEMP_RESOLV_CONF
         add_statically_provisioned_nameservers
      else
         case "$SYSCFG_wan_proto" in
           pppoe | pptp | l2tp)
              for i in $SYSEVENT_wan_ppp_dns ; do
                 echo nameserver $i >> $TEMP_RESOLV_CONF
              done
              ;;
           *)
              for i in $SYSEVENT_wan_dynamic_dns ; do
                 echo nameserver $i >> $TEMP_RESOLV_CONF
              done
              ;;
         esac
      fi
      RESTART_IPV4_DHCP_SERVER=0
 
      if [ -z "$SYSCFG_router_dns_domain" ] ; then
         for i in $SYSEVENT_dhcp_domain ; do
            TEST_NS=`grep " $i" $REAL_RESOLV_CONF`
            if [ "" = "$TEST_NS" ] ; then
               RESTART_IPV4_DHCP_SERVER=1
            fi
         done
      fi
      if [ "1" = "$SYSCFG_dhcp_server_propagate_wan_nameserver" ] ; then
         for i in $SYSEVENT_wan_dynamic_dns ; do
            TEST_NS=`grep  " $i" $REAL_RESOLV_CONF`
            if [ "" = "$TEST_NS" ] ; then
               RESTART_IPV4_DHCP_SERVER=1
            fi
         done
      fi
   fi
   if [ "1" = "$SYSCFG_ipv6_enable" ] ; then
      if [ -n "$SYSEVENT_ipv6_domain" ] ; then
         echo "search $SYSEVENT_ipv6_domain" >> $TEMP_RESOLV_CONF
      fi
      if [ "0" != "$SYSCFG_ipv6_enable" ] ; then
         for server in $SYSEVENT_ipv6_nameserver
         do
            echo "nameserver $server" >> $TEMP_RESOLV_CONF
         done
      fi
      if [  -z  "$SYSCFG_bridge_mode" -o "0" = "$SYSCFG_bridge_mode" ] ; then   
         RESTART_IPV6_DHCP_SERVER=0
         if [ -z "$SYSCFG_router_dns_domain" ] ; then
            for i in $SYSEVENT_ipv6_domain ; do
               TEST_NS=`grep $i $REAL_RESOLV_CONF`
               if [ "" = "$TEST_NS" ] ; then
                  RESTART_IPV6_DHCP_SERVER=1
               fi
            done
         fi
         if [ "1" = "$SYSCFG_dhcp_server_propagate_wan_nameserver" ] ; then
            for i in $SYSEVENT_ipv6_nameserver ; do
               TEST_NS=`grep $i $REAL_RESOLV_CONF`
               if [ "" = "$TEST_NS" ] ; then
                  RESTART_IPV6_DHCP_SERVER=1
               fi
            done
         fi
      fi
   fi
   if [ ! -s $TEMP_RESOLV_CONF ] ; then
      echo "nameserver 127.0.0.1" > $REAL_RESOLV_CONF
      rm -f $TEMP_RESOLV_CONF
   else
      cat $TEMP_RESOLV_CONF > $REAL_RESOLV_CONF
      rm -f $TEMP_RESOLV_CONF
      if [ "1" = "$RESTART_IPV6_DHCP_SERVER" ] ; then
         if [ "started" = `sysevent get dhcpv6_server-status` ] ; then
            sysevent set dhcpv6_server-restart
         fi
      fi
   fi
