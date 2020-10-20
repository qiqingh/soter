    eval `utctx_cmd get router_adv_provisioning_enable wan_ipv6addr wan_ipv6_default_gateway ipv6_verbose_logging wan_if_v6_forwarding`
    SYSEVENT_current_wan_ipv6_ifname=`sysevent get current_wan_ipv6_ifname`
   if [ "1" = "$SYSCFG_ipv6_verbose_logging" ] ; then
      LOG=/var/log/ipv6.log
   else
      LOG=/dev/null
   fi
