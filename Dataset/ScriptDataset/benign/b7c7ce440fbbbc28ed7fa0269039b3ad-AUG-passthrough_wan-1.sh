   eval `utctx_cmd get ipv6_enable ipv6_verbose_logging lan_ifname`
   SYSEVENT_current_lan_ipv6address=`sysevent get current_lan_ipv6address`
   if [ "1" = "$SYSCFG_ipv6_verbose_logging" ] ; then
      LOG=/var/log/ipv6.log
   else
      LOG=/dev/null
   fi
