   SYSCFG_ppp_debug=`syscfg get ppp_debug`
   echo -n > $PPP_OPTIONS_FILE
   if [ "demand" = "$SYSCFG_ppp_conn_method" ]; then
     if [ "l2tp" != "$SYSCFG_wan_proto" ]; then
       echo "demand" >> $PPP_OPTIONS_FILE
     fi
     PPP_IDLE_TIME=`expr $SYSCFG_ppp_idle_time \* 60`
     echo "idle $PPP_IDLE_TIME" >> $PPP_OPTIONS_FILE
     echo "ipcp-accept-remote" >> $PPP_OPTIONS_FILE
     echo "ipcp-accept-local" >> $PPP_OPTIONS_FILE
     echo "connect true" >> $PPP_OPTIONS_FILE
     echo "ktune" >> $PPP_OPTIONS_FILE
     echo "active-filter \"outbound and not ip multicast\"" >> $PPP_OPTIONS_FILE
     echo "ipv6 ," >> $PPP_OPTIONS_FILE
   else
     if [ "l2tp" != "$SYSCFG_wan_proto" ]; then
       echo "persist" >> $PPP_OPTIONS_FILE
     fi
     echo "ipv6 ," >> $PPP_OPTIONS_FILE
   fi
   if [ "pppoe" = "$SYSCFG_wan_proto" ]; then
     if [ -n "$SYSCFG_ppp_lcp_echo_failure" ]; then
       echo "lcp-echo-failure $SYSCFG_ppp_lcp_echo_failure" >> $PPP_OPTIONS_FILE
     else
       echo "lcp-echo-failure 5" >> $PPP_OPTIONS_FILE
     fi
   fi
   if [ "pptp" = "$SYSCFG_wan_proto" ]; then
       echo "lcp-echo-failure 3" >> $PPP_OPTIONS_FILE
   fi
   if [ -z "$SYSCFG_ppp_keepalive_interval" ] || [ "0" = "$SYSCFG_ppp_keepalive_interval" ]; then
     echo "lcp-echo-interval 30" >> $PPP_OPTIONS_FILE
   else
     echo "lcp-echo-interval $SYSCFG_ppp_keepalive_interval" >> $PPP_OPTIONS_FILE
   fi
   echo "noipdefault" >> $PPP_OPTIONS_FILE
   if [ "1" = "$SYSCFG_default" ] ; then
     echo "defaultroute" >> $PPP_OPTIONS_FILE
   fi
   echo "usepeerdns" >> $PPP_OPTIONS_FILE
   echo "user \"$SYSCFG_wan_proto_username\"" >> $PPP_OPTIONS_FILE
   if [ -z "$SYSCFG_wan_mtu" ] || [ "0" = "$SYSCFG_wan_mtu" ]; then
     case "$SYSCFG_wan_proto" in
       pppoe)
       echo "mtu 1492" >> $PPP_OPTIONS_FILE
       ;;
       pptp | l2tp)
       echo "mtu 1460" >> $PPP_OPTIONS_FILE
       ;;
     esac
   else
      echo "mtu $SYSCFG_wan_mtu" >> $PPP_OPTIONS_FILE
   fi
   if [ "pppoe" = "$SYSCFG_wan_proto" ]; then
       echo "mru 1492" >> $PPP_OPTIONS_FILE
   fi
   echo "default-asyncmap" >> $PPP_OPTIONS_FILE
   echo "nopcomp" >> $PPP_OPTIONS_FILE
   echo "noaccomp" >> $PPP_OPTIONS_FILE
   echo "noccp" >> $PPP_OPTIONS_FILE
   echo "novj" >> $PPP_OPTIONS_FILE
   echo "nobsdcomp" >> $PPP_OPTIONS_FILE
   echo "nodeflate" >> $PPP_OPTIONS_FILE
   echo "lock" >> $PPP_OPTIONS_FILE
   echo "noauth" >> $PPP_OPTIONS_FILE
   if [ "1" = "$SYSCFG_ppp_debug" ]; then
      echo "debug" >> $PPP_OPTIONS_FILE
      echo "logfile /var/log/pppd.log" >> $PPP_OPTIONS_FILE
   fi
   if [ "$SYSCFG_wan_proto" = "pptp" ]; then
       echo "refuse-eap" >> $PPP_OPTIONS_FILE
   fi
