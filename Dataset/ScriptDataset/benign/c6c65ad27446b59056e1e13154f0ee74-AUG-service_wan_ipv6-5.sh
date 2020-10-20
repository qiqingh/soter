   SYSCFG_FAILED='false'
   FOO=`utctx_cmd get ipv6_enable wan_proto ipv6_bridging_enable ipv6_static_enable 6rd_enable ipv6_verbose_logging bridge_mode ipv6::passthrough_enable`
   eval $FOO
   if [ $SYSCFG_FAILED = 'true' ] ; then
      ulog ipv6 status "$PID utctx failed to get some configuration data"
      ulog ipv6 status "$PID IPv6 wan cannot be controlled"
      echo "service_init: failed to get some config data" >> $LOG
      exit
   fi
   if [ "1" = "$SYSCFG_ipv6_static_enable" ] ; then
      IPV6_WAN_PROTO=static
      sysevent set ipv6_connection_type Static
   elif [ "1" = "$SYSCFG_ipv6_bridging_enable" ] ; then
      IPV6_WAN_PROTO=bridge
      sysevent set ipv6_connection_type bridge
   elif [ "1" = "$SYSCFG_bridge_mode" -o "2" = "$SYSCFG_bridge_mode" ] ; then
      IPV6_WAN_PROTO=bridge
      syscfg unset dhcpv6c_enable
      syscfg unset dhcpv6s_enable 
      syscfg unset router_adv_enable 
      sysevent set dhcpv6_server-stop
      sysevent set dhcpv6_client-stop
      sysevent set ipv6_connection_type Bridge
   elif [ "1" = "$SYSCFG_ipv6_passthrough_enable" ] ; then
      IPV6_WAN_PROTO=passthrough
      sysevent set ipv6_connection_type passthrough
   elif [ "1" = "$SYSCFG_6rd_enable" ] ; then
      IPV6_WAN_PROTO=6rd
      sysevent set ipv6_connection_type "6rd Tunnel"
   else 
      IPV6_WAN_PROTO=normal
      sysevent set ipv6_connection_type "IPv6 - Automatic"
   fi
   ulog ipv6 status "$PID Using IPv6 wan protocol $IPV6_WAN_PROTO"
   echo "service_init: IPV6_WAN_PROTO=$IPV6_WAN_PROTO" >> $LOG
