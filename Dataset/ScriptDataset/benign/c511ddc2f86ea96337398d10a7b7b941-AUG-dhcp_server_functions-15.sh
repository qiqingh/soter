   WAN_PROTO=`syscfg get wan_proto`
   DHCP_OPTION_STR=
   DNS_OPTION_STR="tag:$SYSCFG_guest_lan_ifname,option:dns-server"
   GW_IP=`syscfg get guest_lan_ipaddr`
   if [ "" != $GW_IP -a "0.0.0.0" != $GW_IP ] ; then
      echo "tag:$SYSCFG_guest_lan_ifname,option:router,$GW_IP" >> $LOCAL_DHCP_OPTIONS_FILE
   fi
   if [ "static" = "$WAN_PROTO" ] && [ "1" = "$PROPAGATE_NS" ] ; then
      NS=`syscfg get nameserver1`
      if [ "0.0.0.0" != "$NS" ]  && [ "" != "$NS" ] ; then
         if [ "" = "$DHCP_OPTION_STR" ] ; then
            DHCP_OPTION_STR="$DNS_OPTION_STR, "$NS
         else
            DHCP_OPTION_STR=$DHCP_OPTION_STR","$NS
         fi
      fi
      NS=`syscfg get nameserver2`
      if [ "0.0.0.0" != "$NS" ] && [ "" != "$NS" ] ; then
         if [ "" = "$DHCP_OPTION_STR" ] ; then
            DHCP_OPTION_STR="$DNS_OPTION_STR, "$NS
         else
            DHCP_OPTION_STR=$DHCP_OPTION_STR","$NS
         fi
      fi
      NS=`syscfg get nameserver3`
      if [ "0.0.0.0" != "$NS" ] && [ "" != "$NS" ] ; then
         if [ "" = "$DHCP_OPTION_STR" ] ; then
           DHCP_OPTION_STR="$DNS_OPTION_STR, "$NS
         else
            DHCP_OPTION_STR=$DHCP_OPTION_STR","$NS
         fi
      fi
   else
      NAMESERVER1=`syscfg get dhcp_nameserver_1`
      NAMESERVER2=`syscfg get dhcp_nameserver_2`
      NAMESERVER3=`syscfg get dhcp_nameserver_3`
   
      if [ "0.0.0.0" != "$NAMESERVER1" ] && [ "" != "$NAMESERVER1" ] ; then
         if [ "" = "$DHCP_OPTION_STR" ] ; then
            DHCP_OPTION_STR="$DNS_OPTION_STR, "$NAMESERVER1
         else
            DHCP_OPTION_STR=$DHCP_OPTION_STR","$NAMESERVER1
         fi
      fi
      if [ "0.0.0.0" != "$NAMESERVER2" ]  && [ "" != "$NAMESERVER2" ]; then
         if [ "" = "$DHCP_OPTION_STR" ] ; then
            DHCP_OPTION_STR="$DNS_OPTION_STR, "$NAMESERVER2
         else
            DHCP_OPTION_STR=$DHCP_OPTION_STR","$NAMESERVER2
         fi
      fi
      if [ "0.0.0.0" != "$NAMESERVER3" ]  && [ "" != "$NAMESERVER3" ]; then
         if [ "" = "$DHCP_OPTION_STR" ] ; then
            DHCP_OPTION_STR="$DNS_OPTION_STR, "$NAMESERVER3
         else
            DHCP_OPTION_STR=$DHCP_OPTION_STR","$NAMESERVER3
         fi
      fi
      if [ "1" = "$PROPAGATE_NS" ] ; then
         NS=` grep "dns server" $LOG_FILE | awk '{print $4}'`
         if [ "" != "$NS" ] ; then
            if [ "" = "$DHCP_OPTION_STR" ] ; then
               DHCP_OPTION_STR="$DNS_OPTION_STR, "$NS
            else
               DHCP_OPTION_STR=$DHCP_OPTION_STR","$NS
            fi
         fi
         NS=` grep "dns server" $LOG_FILE | awk '{print $5}'`
         if [ "" != "$NS" ] ; then
            if [ "" = "$DHCP_OPTION_STR" ] ; then
               DHCP_OPTION_STR="$DNS_OPTION_STR, "$NS
            else
               DHCP_OPTION_STR=$DHCP_OPTION_STR","$NS
            fi
         fi
         NS=` grep "dns server" $LOG_FILE | awk '{print $6}'`
         if [ "" != "$NS" ] ; then
            if [ "" = "$DHCP_OPTION_STR" ] ; then
               DHCP_OPTION_STR="$DNS_OPTION_STR, "$NS
            else
               DHCP_OPTION_STR=$DHCP_OPTION_STR","$NS
            fi
         fi
      fi
   fi
   NS=$GW_IP
   if [ "" != "$NS" ] ; then
      if [ "" = "$DHCP_OPTION_STR" ] ; then
         DHCP_OPTION_STR="$DNS_OPTION_STR, "$NS
      else
         DHCP_OPTION_STR=$DHCP_OPTION_STR","$NS
      fi
   fi
   echo $DHCP_OPTION_STR >> $LOCAL_DHCP_OPTIONS_FILE
   WINS_SERVER=`syscfg get dhcp_wins_server`
   if [ "" != "$WINS_SERVER" ] && [ "0.0.0.0" != "$WINS_SERVER" ] ; then
      echo "option:netbios-ns,"$WINS_SERVER >> $LOCAL_DHCP_OPTIONS_FILE
   fi
