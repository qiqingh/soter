   if [ -z "$interface" ] ; then
      ulog dhcpv6c status "destroy_ia_pd: no interface provided. Ignoring release IA_PD"
      return
   fi
   SYSCFG_lan_ifname=`syscfg get lan_ifname`
   SYSCFG_guest_lan_ifname=`syscfg get guest_lan_ifname`
   LAN_OLD_ADDR=`sysevent get ${SYSCFG_lan_ifname}_dhcpv6_ia_pd_address`
   if [ -n "$LAN_OLD_ADDR" ] ; then
      TEST_PREFIX=`ip6calc -p $LAN_OLD_ADDR`
      LAN_PREFIX=`sysevent get ${SYSCFG_lan_ifname}_ipv6_prefix`
      if [ -n "$LAN_PREFIX" ] ; then
         CUR_PREFIX=`ip6calc -p $LAN_PREFIX`
      fi
      if [ "$TEST_PREFIX" = "$CUR_PREFIX" ] ; then
         ulog dhcpv6c status "Quick Deprecating $SYSCFG_lan_ifname prefix $SYSCFG_lan_ifname"
         quick_deprecate_lan_ipv6_prefix ${SYSCFG_lan_ifname}
      fi
   fi
   GUEST_LAN_OLD_ADDR=`sysevent get ${SYSCFG_guest_lan_ifname}_dhcpv6_ia_pd_address`
   if [ -n "$GUEST_LAN_OLD_ADDR" ] ; then
      TEST_PREFIX=`ip6calc -p $GUEST_LAN_OLD_ADDR`
      LAN_PREFIX=`sysevent get ${SYSCFG_guest_lan_ifname}_ipv6_prefix`
      if [ -n "$LAN_PREFIX" ] ; then
         CUR_PREFIX=`ip6calc -p $LAN_PREFIX`
      fi
      if [ "$TEST_PREFIX" = "$CUR_PREFIX" ] ; then
         ulog dhcpv6c status "Quick Deprecating $SYSCFG_lan_ifname prefix $SYSCFG_lan_ifname"
         quick_deprecate_lan_ipv6_prefix ${SYSCFG_guest_lan_ifname}
      fi
   fi
   sysevent set radvd-reload
   ulog dhcpv6c status "destroy_ia_pd: Called radvd-reload"
