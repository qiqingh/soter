   
   if [ "1" = "$SYSCFG_default" ] ; then
      sysevent set default_router $SYSCFG_wan_default_gateway
      sysevent set ipv4_wan_ipaddr $SYSCFG_wan_ipaddr
      sysevent set ipv4_wan_subnet $SYSCFG_wan_netmask
      sysevent set wan_start_time `cat /proc/uptime | cut -d'.' -f1`
   fi
   sysevent set ${NAMESPACE}_ipv4_wan_ipaddr $SYSCFG_wan_ipaddr
   sysevent set ${NAMESPACE}_ipv4_wan_subnet $SYSCFG_wan_netmask
   sysevent set ${NAMESPACE}_ipv4_default_router $SYSCFG_wan_default_gateway
   sysevent set ${NAMESPACE}_wan_start_time `cat /proc/uptime | cut -d'.' -f1`
   sysevent set ${NAMESPACE}_current_ipv4_wan_state up
   prepare_resolver_conf
   sysevent set ${NAMESPACE}-errinfo
   sysevent set ${NAMESPACE}-status started
   sysevent set firewall-restart
