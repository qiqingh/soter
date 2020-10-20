   if [ -z "$interface" ] ; then
      ulog dhcpv6c status "release_ia_pd: no interface provided. Ignoring release IA_PD"
      return
   fi
   SYSCFG_lan_ifname=`syscfg get lan_ifname`
   SYSCFG_guest_lan_ifname=`syscfg get guest_lan_ifname`
   OLD_ADDR=`sysevent get ${SYSCFG_lan_ifname}_dhcpv6_ia_pd_address`
   if [ -n "$OLD_ADDR" ] ; then
      ulog dhcpv6c status "release_ia_pd: Removing $OLD_ADDR from $SYSCFG_lan_ifname"
      ip -6 addr del $OLD_ADDR dev $SYSCFG_lan_ifname scope global
      sysevent set ${SYSCFG_lan_ifname}_dhcpv6_ia_pd_address
      TEST_PREFIX=`ip6calc -p $OLD_ADDR`
      LAN_PREFIX=`sysevent get ${SYSCFG_lan_ifname}_ipv6_prefix`
      if [ -n "$LAN_PREFIX" ] ; then
         CUR_PREFIX=`ip6calc -p $LAN_PREFIX`
      fi
      if [ "$TEST_PREFIX" = "$CUR_PREFIX" ] ; then
         deprecate_lan_ipv6_prefix $SYSCFG_lan_ifname
         ulog dhcpv6c status "Releasing $SYSCFG_lan_ifname prefix"
      fi
   fi
   OLD_ADDR=`sysevent get ${SYSCFG_guest_lan_ifname}_dhcpv6_ia_pd_address`
   if [ -n "$OLD_ADDR" ] ; then
      ulog dhcpv6c status "release_ia_pd: Removing $OLD_ADDR from $SYSCFG_guest_lan_ifname"
      ip -6 addr del $OLD_ADDR dev $SYSCFG_guest_lan_ifname scope global
      sysevent set ${SYSCFG_guest_lan_ifname}_dhcpv6_ia_pd_address
      TEST_PREFIX=`ip6calc -p $OLD_ADDR`
      LAN_PREFIX=`sysevent get ${SYSCFG_guest_lan_ifname}_ipv6_prefix`
      if [ -n "$LAN_PREFIX" ] ; then
         CUR_PREFIX=`ip6calc -p $LAN_PREFIX`
      fi
      if [ "$TEST_PREFIX" = "$CUR_PREFIX" ] ; then
         save_lan_ipv6_prefix $SYSCFG_guest_lan_ifname
         ulog dhcpv6c status "Releasing $SYSCFG_guest_lan_ifname prefix"
      fi
   fi
   SYSCFG_loopback_ifname=lo
   OLD_ADDR=`sysevent get ${SYSCFG_loopback_ifname}_dhcpv6_ia_pd_address`
   if [ -n "$OLD_ADDR" ] ; then
      ulog dhcpv6c status "release_ia_pd: Removing $OLD_ADDR from $SYSCFG_loopback_ifname"
      ip -6 addr del $OLD_ADDR dev $SYSCFG_loopback_ifname scope global
      sysevent set ${SYSCFG_loopback_ifname}_dhcpv6_ia_pd_address
   fi
   delete_unreachable_ipv6route
   sysevent set ipv6_delegated_prefix
   sysevent set radvd-reload
