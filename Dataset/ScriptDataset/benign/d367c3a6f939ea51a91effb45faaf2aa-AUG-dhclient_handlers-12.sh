   if [ -z "$interface" ] ; then
      ulog dhcpv6c status "renew_ia_pd: no interface provided. Ignoring IA_PD"
      return
   fi
   if [ -z "$new_ip6_prefix" ] ; then
      ulog dhcpv6c status "renew_ia_pd: no new prefix provided. Ignoring IA_PD"
      return
   fi
   NOW=`date +%s`
   SYSCFG_lan_ifname=`syscfg get lan_ifname`
   SYSCFG_guest_lan_ifname=`syscfg get guest_lan_ifname`
   if [ "$new_ip6_prefix" = "`sysevent get ipv6_delegated_prefix`" ] ; then
      sysevent set ipv6_delegated_prefix_lifetime $new_max_life
      sysevent set ipv6_delegated_prefix_time_received $NOW
      ulog dhcpv6c status "renew_ia_pd renewing delegated prefix"
    fi
   TEST_PREFIX=`ip6calc -p $new_ip6_prefix`
   LAN_PREFIX=`sysevent get ${SYSCFG_lan_ifname}_ipv6_prefix`
   if [ -n "$LAN_PREFIX" ] ; then
      CUR_PREFIX=`ip6calc -p $LAN_PREFIX`
   fi
   if [ "$TEST_PREFIX" = "$CUR_PREFIX" ] ; then
      save_lan_ipv6_prefix $SYSCFG_lan_ifname  $LAN_PREFIX $new_max_life $new_preferred_life
      ulog dhcpv6c status "Updated $SYSCFG_lan_ifname prefix $LAN_PREFIX $new_max_life $new_preferred_life"
   fi
   LAN_PREFIX=`sysevent get ${SYSCFG_guest_lan_ifname}_ipv6_prefix`
   if [ -n "$LAN_PREFIX" ] ; then
      if [ "$TEST_PREFIX" = "$CUR_PREFIX" ] ; then
         save_lan_ipv6_prefix $SYSCFG_guest_lan_ifname $LAN_PREFIX  $new_max_life $new_preferred_life
         ulog dhcpv6c status "Updated $SYSCFG_guest_lan_ifname prefix $LAN_PREFIX $new_max_life $new_preferred_life"
      fi
   fi
   sysevent set radvd-reload
