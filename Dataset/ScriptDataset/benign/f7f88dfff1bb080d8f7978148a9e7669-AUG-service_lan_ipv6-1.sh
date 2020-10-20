   SYSCFG_FAILED='false'
   FOO=`utctx_cmd get ipv6_enable lan_ifname ula_enable lan_ula_prefix lo_ula_prefix dns_server_private_name private_domain ipv6_static_enable lan_ipv6_prefix guest_lan_ifname guest_enabled ipv6_verbose_logging`
   eval $FOO
  if [ $SYSCFG_FAILED = 'true' ] ; then
     ulog ipv6_lan status "$PID utctx failed to get some configuration data"
     ulog ipv6_lan status "$PID IPV6 LAN CANNOT BE CONTROLLED"
     exit
  fi
   SYSEVENT_current_lan_ipv6address=`sysevent get current_lan_ipv6address`
   SYSEVENT_current_guest_lan_ipv6address=`sysevent get current_guest_lan_ipv6address`
   SYSEVENT_current_lo_ipv6address=`sysevent get current_lo_ipv6address`
   if [ "1" = "$SYSCFG_ipv6_verbose_logging" ] ; then
      LOG=/var/log/ipv6.log
   else
      LOG=/dev/null
   fi
