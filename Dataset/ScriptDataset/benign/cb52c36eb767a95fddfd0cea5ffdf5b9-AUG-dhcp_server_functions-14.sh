   WAN_PROTO=`syscfg get wan_proto`
   DHCP_OPTION_STR=
   DNS_OPTION_STR="tag:$SYSCFG_guest_lan_ifname,option:dns-server"
   GW_IP=`syscfg get guest_lan_ipaddr`
   if [ "" != $GW_IP -a "0.0.0.0" != $GW_IP ] ; then
      echo "tag:$SYSCFG_guest_lan_ifname,option:router,$GW_IP" >> $LOCAL_DHCP_OPTIONS_FILE
   fi
   NS=$GW_IP
   if [ -n "$NS" ] ; then
      if [ -z "$DHCP_OPTION_STR" ] ; then
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
