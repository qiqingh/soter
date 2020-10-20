   if [ -z "$interface" ] ; then
      ulog dhcpv6c status "release_ia_na: no interface provided. Ignoring release IA_NA"
      return
   fi
   IPV6_ADDR=`sysevent get ${interface}_dhcpv6_ia_na`
   if [ -z "$IPV6_ADDR" ] ; then
      return
   fi
   if [ "dhcp" = "`sysevent get current_wan_ipv6address_owner`" ] ; then
      ulog dhcpv6c status "release_ia_na: releasing $IPV6_ADDR as current_wan_ipv6address"
      sysevent set current_wan_ipv6address_owner
      sysevent set current_wan_ipv6address
   fi
   ulog dhcpv6c status "release_ia_na: releasing $IPV6_ADDR from $interface"
   ip -6 addr del $IPV6_ADDR dev $interface
   sysevent set ${interface}_dhcpv6_ia_na
   sysevent set wan_dhcpv6_lease $new_max_life
