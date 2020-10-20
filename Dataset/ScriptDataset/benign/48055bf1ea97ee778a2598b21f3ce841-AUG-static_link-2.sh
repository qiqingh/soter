   
   SAVE=""
   if [ -n "$SYSCFG_ifname" -a "$SYSEVENT_current_wan_ifname" != "$SYSCFG_ifname" ]; then
       SAVE="$SYSEVENT_current_wan_ifname"
       SYSEVENT_current_wan_ifname="$SYSCFG_ifname"
   fi
   if [ "1" = "$SYSCFG_default" ] ; then
      ip -4 route del default dev $SYSEVENT_current_wan_ifname via $SYSCFG_wan_default_gateway
      ip -4 route del $SYSCFG_wan_default_gateway dev $SYSEVENT_current_wan_ifname
   else
      ip -4 route del ${SYSCFG_wan_ipaddr}/${SYSCFG_wan_netmask} dev $SYSEVENT_current_wan_ifname via $SYSCFG_wan_default_gateway
      ip -4 route del $SYSCFG_wan_default_gateway dev $SYSEVENT_current_wan_ifname
   fi
   ip -4 route flush cache
   ip -4 addr flush dev $SYSEVENT_current_wan_ifname
   
   if [ "$SAVE" != "$SYSEVENT_current_wan_ifname" ]; then
       SYSEVENT_current_wan_ifname="$SAVE"
   fi
   ulog static_wan_link status "$PID setting ${NAMESPACE}_current_ipv4_link_state down"
   sysevent set ${NAMESPACE}_current_ipv4_link_state down
