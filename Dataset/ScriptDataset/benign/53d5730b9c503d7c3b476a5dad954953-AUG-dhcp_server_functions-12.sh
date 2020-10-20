   if [ -z "$1" ] ; then
     return
   fi
   DHCP_OPTION_NAMESERVER_STR="tag:$SYSCFG_lan_ifname,option:dns-server"
   NAMESERVER1=`syscfg get dhcp_nameserver_1`
   NAMESERVER2=`syscfg get dhcp_nameserver_2`
   NAMESERVER3=`syscfg get dhcp_nameserver_3`
   
   if [ -n "$NAMESERVER1" -a  "0.0.0.0" != "$NAMESERVER1" ] ; then
      DHCP_OPTION_NAMESERVER_STR=$DHCP_OPTION_NAMESERVER_STR","$NAMESERVER1
   fi
   if [ -n "$NAMESERVER2" -a  "0.0.0.0" != "$NAMESERVER2" ] ; then
      DHCP_OPTION_NAMESERVER_STR=$DHCP_OPTION_NAMESERVER_STR","$NAMESERVER2
   fi
   if [ -n "$NAMESERVER3" -a  "0.0.0.0" != "$NAMESERVER3" ] ; then
      DHCP_OPTION_NAMESERVER_STR=$DHCP_OPTION_NAMESERVER_STR","$NAMESERVER3
   fi
   SYSCFG_dhcp_server_propagate_wan_nameserver=`syscfg get dhcp_server_propagate_wan_nameserver`
   if [ "1" = "$SYSCFG_dhcp_server_propagate_wan_nameserver" ] ; then
      for i in wan_1 wan_2 wan_3
      do
         wan_info_by_namespace $i
         if [ "0" = "$?" ] ; then
            if [ "static" = "$SYSCFG_wan_proto" -a "1" = "$SYSCFG_forwarding" ] ; then
               if [ -n "$SYSCFG_nameserver1" -a "0.0.0.0" != "$SYSCFG_nameserver1" ] ; then
                  DHCP_OPTION_NAMESERVER_STR=$DHCP_OPTION_NAMESERVER_STR","$SYSCFG_nameserver1
               fi
               if [ -n "$SYSCFG_nameserver2" -a "0.0.0.0" != "$SYSCFG_nameserver2" ] ; then
                  DHCP_OPTION_NAMESERVER_STR=$DHCP_OPTION_NAMESERVER_STR","$SYSCFG_nameserver2
               fi
               if [ -n "$SYSCFG_nameserver3" -a "0.0.0.0" != "$SYSCFG_nameserver3" ] ; then
                  DHCP_OPTION_NAMESERVER_STR=$DHCP_OPTION_NAMESERVER_STR","$SYSCFG_nameserver3
               fi
            fi
         fi
      done
      for i in wan_1 wan_2 wan_3
      do
         wan_info_by_namespace $i
         INTERFACE_DHCP_LOG_FILE="/tmp/"${i}"_udhcp.log"
         if [ -f "$INTERFACE_DHCP_LOG_FILE" ] ; then
            NS=` grep "dns server" $INTERFACE_DHCP_LOG_FILE | awk '{print $4}'`
            if [ -n "$NS" ] ; then
               DHCP_OPTION_NAMESERVER_STR=$DHCP_OPTION_NAMESERVER_STR","$NS
            fi
            NS=` grep "dns server" $INTERFACE_DHCP_LOG_FILE | awk '{print $5}'`
            if [ -n "$NS" ] ; then
               DHCP_OPTION_NAMESERVER_STR=$DHCP_OPTION_NAMESERVER_STR","$NS
            fi
            NS=` grep "dns server" $INTERFACE_DHCP_LOG_FILE | awk '{print $6}'`
            if [ -n "$NS" ] ; then
               DHCP_OPTION_NAMESERVER_STR=$DHCP_OPTION_NAMESERVER_STR","$NS
            fi
         fi
      done
   fi
   NS=` syscfg get lan_ipaddr `
   if [ -n "$NS" ] ; then
      DHCP_OPTION_NAMESERVER_STR=$DHCP_OPTION_NAMESERVER_STR","$NS
   fi
   echo $DHCP_OPTION_NAMESERVER_STR >> $1
