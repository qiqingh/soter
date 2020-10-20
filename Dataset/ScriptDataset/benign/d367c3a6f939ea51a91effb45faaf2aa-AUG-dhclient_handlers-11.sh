   if [ -z "$interface" ] ; then
      ulog dhcpv6c status "new_ia_pd: no interface provided. Ignoring IA_PD"
      return
   fi
   if [ -z "$new_ip6_prefix" ] ; then
      ulog dhcpv6c status "new_ia_pd: no new prefix provided. Ignoring IA_PD"
      return
   fi
   SYSCFG_lan_ifname=`syscfg get lan_ifname`
   SYSCFG_guest_enabled=`syscfg get guest_enabled`
   SYSCFG_guest_lan_ifname=`syscfg get guest_lan_ifname`
   delete_guest_lan_ipv6address
   delete_loopback_ipv6address
   delete_unreachable_ipv6route
   prefix=`echo $new_ip6_prefix | cut -d '/' -f1`
   prefix_length=`echo $new_ip6_prefix | cut -d '/' -f2`
   ulog dhcpv6c status "The DHCPv6 Server gave prefix ${prefix}/${prefix_length}"
   if [ "$prefix_length" -gt "62" ] ; then
      ulog dhcpv6c error "The ISP DHCPv6 Server gave a prefix of length $prefix_length, we expect /62 to fully provision lan."
      if [ "$prefix_length" -gt "64" ] ; then
         ulog dhcpv6c error "Prefix length is $prefix_length, we can not provision lan. $prefix/$prefix_length is ignored."
         exit
      fi
   fi
   sysevent set ipv6_delegated_prefix "$prefix/$prefix_length"
   sysevent set ipv6_delegated_prefix_lifetime $new_max_life
   sysevent set ipv6_delegated_prefix_time_received `date +%s`
   eval `ipv6_prefix_calc $prefix $prefix_length 0 0 3 64`
   if [ -n "$IPv6_PREFIX_1" ] ; then
      provision_interface_using_prefix $SYSCFG_lan_ifname $IPv6_PREFIX_1 
      save_lan_ipv6_prefix $SYSCFG_lan_ifname $IPv6_PREFIX_1 $new_max_life $new_preferred_life
   fi
   if [ -n "$IPv6_PREFIX_3" ] ; then
      loopback_ifname=lo
      eval `ip6calc -p ${IPv6_PREFIX_3}`
      eval `ip6calc -o ${PREFIX} ::1`
      LOOPBACK_ADDRESS=$OR
      ulog dhcpv6c status "Assigning $LOOPBACK_ADDRESS to $loopback_ifname"
      ip -6 addr add ${LOOPBACK_ADDRESS}/64 dev $loopback_ifname scope global  2>&1
      sysevent set ${loopback_ifname}_dhcpv6_ia_pd_address ${LOOPBACK_ADDRESS}/64
   fi
   if [ -n "$IPv6_PREFIX_2" ] ; then
      if [ "1" = "$SYSCFG_guest_enabled" ] ; then
         provision_interface_using_prefix $SYSCFG_guest_lan_ifname $IPv6_PREFIX_2 
         save_lan_ipv6_prefix $SYSCFG_guest_lan_ifname $IPv6_PREFIX_2 $new_max_life $new_preferred_life
      else
         if [ -z "$IPv6_PREFIX_3" ] ; then
            loopback_ifname=lo
            eval `ip6calc -p ${IPv6_PREFIX_2}`
            eval `ip6calc -o ${PREFIX} ::1`
            LOOPBACK_ADDRESS=$OR
            ulog dhcpv6c status "Assigning $LOOPBACK_ADDRESS to $loopback_ifname"
            sysevent set ${loopback_ifname}_dhcpv6_ia_pd_address ${LOOPBACK_ADDRESS}/64
            ip -6 addr add ${LOOPBACK_ADDRESS}/64 dev $loopback_ifname scope global  2>&1
         fi
      fi
   fi
   sysevent set radvd-reload
