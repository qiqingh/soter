   SYSCFG_lan_ifname=`syscfg get lan_ifname`
   SYSCFG_guest_lan_ifname=`syscfg get guest_lan_ifname`
   SYSCFG_loopback_ifname=lo
   LAN_OLD_ADDR=`sysevent get ${SYSCFG_lan_ifname}_dhcpv6_ia_pd_address`
   GUEST_LAN_OLD_ADDR=`sysevent get ${SYSCFG_guest_lan_ifname}_dhcpv6_ia_pd_address`
   LO_OLD_ADDR=`sysevent get ${SYSCFG_loopback_ifname}_dhcpv6_ia_pd_address`
   ulog dhcpv6c info "panic received. destroying prefix"
   destroy_ia_pd
   ulog dhcpv6c info "panic. Giving a chance radvd to deprecate the prefix"
   sleep 1
   if [ -n "$LAN_OLD_ADDR" ] ; then
      ip -6 addr del $LAN_OLD_ADDR dev $SYSCFG_lan_ifname
      sysevent set ${SYSCFG_lan_ifname}_dhcpv6_ia_pd_address
   fi
   if [ -n "$GUEST_LAN_OLD_ADDR" ] ; then
      ip -6 addr del $GUEST_LAN_OLD_ADDR dev $SYSCFG_lan_ifname
      sysevent set ${SYSCFG_guest_lan_ifname}_dhcpv6_ia_pd_address
   fi
   if [ -n "$LO_OLD_ADDR" ] ; then
      ip -6 addr del $LO_OLD_ADDR dev $SYSCFG_loopback_ifname scope global
      sysevent set ${SYSCFG_loopback_ifname}_dhcpv6_ia_pd_address
   fi
   ulog dhcpv6c info "panic. Removed all addresses"
   sysevent set ipv6_delegated_prefix
   delete_unreachable_ipv6route
