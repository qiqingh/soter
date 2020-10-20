   echo -n > $LOCAL_DHCP_OPTIONS_FILE
   WAN_PROTO=`syscfg get wan_proto`
   GW_IP=`syscfg get lan_ipaddr`
   if [ "" != $GW_IP -a "0.0.0.0" != $GW_IP ] ; then
      echo "tag:$SYSCFG_lan_ifname,option:router,$GW_IP" >> $LOCAL_DHCP_OPTIONS_FILE
   fi
   prepare_dhcp_options_nameservers $LOCAL_DHCP_OPTIONS_FILE
   WINS_SERVER=`syscfg get dhcp_wins_server`
   if [ "" != "$WINS_SERVER" ] && [ "0.0.0.0" != "$WINS_SERVER" ] ; then
      echo "option:netbios-ns,"$WINS_SERVER >> $LOCAL_DHCP_OPTIONS_FILE
   fi
