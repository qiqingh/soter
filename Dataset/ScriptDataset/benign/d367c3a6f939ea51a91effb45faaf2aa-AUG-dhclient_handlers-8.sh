   if [ -z "$interface" ] ; then
      ulog dhcpv6c status "deprecate_ia_pd: no interface provided. Ignoring release IA_PD"
      return
   fi
   SYSCFG_lan_ifname=`syscfg get lan_ifname`
   SYSCFG_guest_lan_ifname=`syscfg get guest_lan_ifname`
   LAN_OLD_ADDR=`sysevent get ${SYSCFG_lan_ifname}_dhcpv6_ia_pd_address`
   if [ -n "$LAN_OLD_ADDR" ] ; then
      ulog dhcpv6c status "deprecate_ia_pd: Deprecating $LAN_OLD_ADDR from $SYSCFG_lan_ifname"
      add_deprecated_delegated_address $SYSCFG_lan_ifname $LAN_OLD_ADDR
      ulog dhcpv6c status "deprecate_ia_pd: Clearing $LAN_OLD_ADDR from $SYSCFG_lan_ifname"
      sysevent set ${SYSCFG_lan_ifname}_dhcpv6_ia_pd_address
      TEST_PREFIX=`ip6calc -p $LAN_OLD_ADDR`
      LAN_PREFIX=`sysevent get ${SYSCFG_lan_ifname}_ipv6_prefix`
      if [ -n "$LAN_PREFIX" ] ; then
         CUR_PREFIX=`ip6calc -p $LAN_PREFIX`
      fi
      if [ "$TEST_PREFIX" = "$CUR_PREFIX" ] ; then
         save_lan_ipv6_prefix $SYSCFG_lan_ifname
         ulog dhcpv6c status "Deprecating $SYSCFG_lan_ifname prefix $SYSCFG_lan_ifname"
      fi
   fi
   GUEST_LAN_OLD_ADDR=`sysevent get ${SYSCFG_guest_lan_ifname}_dhcpv6_ia_pd_address`
   if [ -n "$GUEST_LAN_OLD_ADDR" ] ; then
      ulog dhcpv6c status "deprecate_ia_pd: Deprecating $GUEST_LAN_OLD_ADDR from $SYSCFG_guest_lan_ifname"
      add_deprecated_delegated_address $SYSCFG_guest_lan_ifname $GUEST_LAN_OLD_ADDR
      ulog dhcpv6c status "deprecate_ia_pd: Clearing $GUEST_LAN_OLD_ADDR from $SYSCFG_lan_ifname"
      sysevent set ${SYSCFG_guest_lan_ifname}_dhcpv6_ia_pd_address
      TEST_PREFIX=`ip6calc -p $GUEST_LAN_OLD_ADDR`
      LAN_PREFIX=`sysevent get ${SYSCFG_guest_lan_ifname}_ipv6_prefix`
      if [ -n "$LAN_PREFIX" ] ; then
         CUR_PREFIX=`ip6calc -p $LAN_PREFIX`
      fi
      if [ "$TEST_PREFIX" = "$CUR_PREFIX" ] ; then
         save_lan_ipv6_prefix $SYSCFG_guest_lan_ifname
         ulog dhcpv6c status "Deprecating $SYSCFG_guest_lan_ifname prefix $SYSCFG_lan_ifname"
      fi
   fi
   SYSCFG_loopback_ifname=lo
   LO_OLD_ADDR=`sysevent get ${SYSCFG_loopback_ifname}_dhcpv6_ia_pd_address`
   if [ -n "$LO_OLD_ADDR" ] ; then
      ulog dhcpv6c status "deprecate_ia_pd: Removing $LO_OLD_ADDR from $SYSCFG_loopback_ifname"
      ip -6 addr del $LO_OLD_ADDR dev $SYSCFG_loopback_ifname scope global
      sysevent set ${SYSCFG_loopback_ifname}_dhcpv6_ia_pd_address
   fi
   delete_unreachable_ipv6route
   sysevent set ipv6_delegated_prefix
   sysevent set radvd-reload
   LIFETIME=`sysevent get ipv6_delegated_prefix_lifetime`
   START=`sysevent get ipv6_delegated_prefix_time_received`
   NOW=`date +%s`
   EXPIRE_AT=`expr $START + $LIFETIME`
   REMAINING=`expr $EXPIRE_AT - $NOW`
   MINS_TO_EXPIRE=0
   if [ "$REMAINING" -gt "0" ] ; then
      MINS_TO_EXPIRE=`expr $REMAINING / 60`
   fi
   if [ "$MINS_TO_EXPIRE" -le "0" ] ; then
      MINS_TO_EXPIRE=1
   fi
   if [ -n "$LAN_OLD_ADDR" ] ; then
      ulog dhcpv6c status "deprecate_ia_pd: Setting cron for $LAN_OLD_ADDR from $SYSCFG_lan_ifname in $MINS_TO_EXPIRE minutes"
      make_cron_timeout_file $SYSCFG_lan_ifname $LAN_OLD_ADDR $MINS_TO_EXPIRE
   fi
