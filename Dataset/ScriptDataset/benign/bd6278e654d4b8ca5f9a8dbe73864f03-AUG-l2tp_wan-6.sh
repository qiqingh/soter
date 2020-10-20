   WMON_STATE=`sysevent get wmon_state`
   if [ "started" = "$WMON_STATE" ] ; then
      ulog l2tp_wan status "$PID bring_wan_up already started. Exit"
      exit 0
   fi
   if [ "l2tp" = "$SYSCFG_wan_proto" ] ; then
      sysevent set wmon_state started
      ulog l2tp_wan status "$PID bring_wan_up"
      register_firewall_hooks
      WAN_ADDR=`sysevent get ipv4_wan_ipaddr`
      sysevent set pppd_current_wan_ipaddr $WAN_ADDR
      sysevent set pppd_current_wan_subnet
      sysevent set pppd_current_wan_ifname
      sysevent set ppp_status
      sysevent set firewall-restart
      prepare_l2tp
      sysevent set ${NAMESPACE}-errinfo
      do_start_wan_monitor $NAMESPACE
      sysevent set ${NAMESPACE}_wan_start_time `cat /proc/uptime | cut -d'.' -f1`
      if [ "1" = "$SYSCFG_default" ] ; then
         sysevent set wan_start_time `cat /proc/uptime | cut -d'.' -f1`
      fi
   fi
