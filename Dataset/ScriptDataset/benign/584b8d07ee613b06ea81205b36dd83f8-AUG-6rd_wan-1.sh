   eval `utctx_cmd get 6rd_zone 6rd_zone_length 6rd_relay 6rd_common_prefix4 ipv6_verbose_logging lan_ifname guest_enabled guest_lan_ifname`
   SYSEVENT_ipv4_wan_ipaddr=`sysevent get ipv4_wan_ipaddr`
   SYSEVENT_current_lan_ipv6address=`sysevent get current_lan_ipv6address`
   SYSEVENT_current_guest_lan_ipv6address=`sysevent get current_guest_lan_ipv6address`
   SYSEVENT_current_lo_ipv6address=`sysevent get current_lo_ipv6address`
   if [ "1" = "$SYSCFG_ipv6_verbose_logging" ] ; then
      LOG=/var/log/ipv6.log
   else
      LOG=/dev/null
   fi
