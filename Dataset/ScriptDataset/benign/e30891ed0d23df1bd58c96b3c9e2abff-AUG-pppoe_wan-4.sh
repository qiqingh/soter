   WMON_STATE=`sysevent get wmon_state`
   if [ "started" = "$WMON_STATE" ] ; then
      ulog pppoe_wan status "$PID bring_wan_up already started. Exit"
      exit 0
   fi
   if [ "pppoe" = "$SYSCFG_wan_proto" ] ; then
      sysevent set wmon_state started
      ulog pppoe_wan status "$PID bring_wan_up"
      sysevent set pppd_current_wan_ipaddr
      sysevent set pppd_current_wan_subnet
      sysevent set pppd_current_wan_ifname
      prepare_pppoe
      sysevent set ${NAMESPACE}-errinfo
      sysevent set ${NAMESPACE}-status started
      do_start_wan_monitor $NAMESPACE
      sysevent set ${NAMESPACE}_wan_start_time `cat /proc/uptime | cut -d'.' -f1`
      if [ "1" = "$SYSCFG_default" ] ; then
         sysevent set wan_start_time `cat /proc/uptime | cut -d'.' -f1`
      fi
   fi
