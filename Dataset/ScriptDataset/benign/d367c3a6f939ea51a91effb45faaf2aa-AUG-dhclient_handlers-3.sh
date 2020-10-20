   RETURN_CODE=0
   if [ -z "$interface" ] ; then
      ulog dhcpv6c status "new_ia_na: no interface provided. Ignoring IA_NA"
      return $RETURN_CODE
   fi
   if [ -z "$new_ip6_address" ] ; then
      ulog dhcpv6c status "new_ia_na: no new ip6 address provided. Ignoring IA_NA"
      return $RETURN_CODE
   fi
   if [ -n "$new_ip6_prefixlen" ] ; then
      TENTATIVE_ADDR="${new_ip6_address}/${new_ip6_prefixlen}"
   else
      TENTATIVE_ADDR="${new_ip6_address}/128"
   fi
   IPV6_ADDR=`sysevent get ${interface}_dhcpv6_ia_na`
   if [ -n "$IPV6_ADDR" ] ; then
      if [ "$IPV6_ADDR" = "$TENTATIVE_ADDR" ] ; then
         ulog dhcpv6c status "new_ia_na: $interface is already provisioned with $TENTATIVE_ADDR"
         return $RETURN_CODE
      else
         ulog dhcpv6c status "new_ia_na: $interface is provisioned with $IPV6_ADDR. Changing to $new_ip6_address"
         ip -6 addr del $IPV6_ADDR dev $interface
         sysevent set ${interface}_dhcpv6_ia_na
      fi
   fi
   ulog dhcpv6c status "new_ia_na: Provisioning $interface with $TENTATIVE_ADDR"
   ip -6 addr add $TENTATIVE_ADDR dev $interface scope global
   do_duplicate_address_detection $interface $TENTATIVE_ADDR
   if [ "$?" != "0" ] ; then
      ulog dhcpv6c status "new_ia_na: $TENTATIVE_ADDR failed DAD."
      ip -6 addr del $TENTATIVE_ADDR dev $interface scope global
      RETURN_CODE=3
   else
      sysevent set ${interface}_dhcpv6_ia_na $TENTATIVE_ADDR
      CHOPPED_ADDR=`echo $TENTATIVE_ADDR | cut -d'/' -f1`
      ulog dhcpv6c status "new_ia_na: making $CHOPPED_ADDR the current_wan_ipv6address"
      sysevent set current_wan_ipv6address $CHOPPED_ADDR
      sysevent set current_wan_ipv6address_owner dhcp
      if [ -n "$new_max_life" ] ; then
         sysevent set wan_dhcpv6_lease $new_max_life
      fi
   fi
   return $RETURN_CODE
