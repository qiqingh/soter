   ip -4 addr add  $SYSCFG_wan_ipaddr/$SYSCFG_wan_netmask broadcast + dev $SYSEVENT_current_wan_ifname
   ip -4 link set $SYSEVENT_current_wan_ifname up
   if [ "1" = "$SYSCFG_default" ] ; then
      OLD_ROUTE=`ip -4 route show | grep default | grep dslite`
      if [ -n "$OLD_ROUTE" ] ; then
         ip -4 route del $OLD_ROUTE
      fi
      ip -4 route add $SYSCFG_wan_default_gateway dev $SYSEVENT_current_wan_ifname
      ip -4 route add default dev $SYSEVENT_current_wan_ifname via $SYSCFG_wan_default_gateway
   else
      ip -4 route add $SYSCFG_wan_default_gateway dev $SYSEVENT_current_wan_ifname
      ip -4 route add ${SYSCFG_wan_ipaddr}/${SYSCFG_wan_netmask} dev $SYSEVENT_current_wan_ifname via $SYSCFG_wan_default_gateway
   fi
   ip -4 route flush cache
   ulog static_wan_link status "$PID setting ${NAMESPACE}_current_ipv4_link_state up"
   sysevent set ${NAMESPACE}_current_ipv4_link_state up
