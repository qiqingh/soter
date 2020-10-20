   ulog l2tp_wan status "$PID bring_wan_down"
   unregister_firewall_hooks
   do_stop_wan_monitor
   if [ "1" = "$SYSCFG_default" ] ; then
      sysevent set ipv4_wan_ipaddr
      sysevent set ipv4_wan_subnet 
      sysevent set wan_start_time
      sysevent set default_router
   fi
   sysevent set pppd_current_wan_ipaddr
   sysevent set pppd_current_wan_subnet
   sysevent set pppd_current_wan_ifname
   sysevent set ${NAMESPACE}_ipv4_wan_ipaddr
   sysevent set ${NAMESPACE}_ipv4_wan_subnet
   sysevent set ${NAMESPACE}_ipv4_default_router
   sysevent set ${NAMESPACE}-errinfo
   sysevent set ${NAMESPACE}-status stopped
   sysevent set ${NAMESPACE}_current_ipv4_wan_state down
   sysevent set wmon_state
   sysevent set firewall-restart
