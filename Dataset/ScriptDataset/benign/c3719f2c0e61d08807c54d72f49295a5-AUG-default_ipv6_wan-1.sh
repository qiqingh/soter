    eval `utctx_cmd get router_adv_provisioning_enable dhcpv6c_enable lan_ifname ipv6_verbose_logging guest_enabled guest_lan_ifname wan_if_v6_forwarding`
    SYSEVENT_current_wan_ipv6_ifname=`sysevent get current_wan_ipv6_ifname`
    if [ -z "$SYSEVENT_current_wan_ipv6_ifname" ] ; then 
      SYSEVENT_current_wan_ipv6_ifname=`sysevent get current_wan_ifname`
      if [ -n "$SYSEVENT_current_wan_ipv6_ifname" ] ; then
         if [ "dslite" = "$CUR_NAME" ] ; then
            ulog default_ipv6_wan status "$PID current_wan_ipv6_name is not set. Cannot set to dslite. Aborting ipv6 init"
            exit 0
         else
            ulog default_ipv6_wan status "$PID current_wan_ipv6_name is not set. Setting internally to current_wan_ifname $SYSEVENT_current_wan_ipv6_ifname"
         fi
      else
         ulog default_ipv6_wan status "$PID current_wan_ipv6_name is not set.  Neither is current_wan_ifname. aborting ipv6 init"
         exit 0
      fi
    fi
   if [ "1" = "$SYSCFG_ipv6_verbose_logging" ] ; then
      LOG=/var/log/ipv6.log
   else
      LOG=/dev/null
   fi
