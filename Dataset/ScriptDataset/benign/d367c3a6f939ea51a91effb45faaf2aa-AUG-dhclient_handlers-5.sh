   SYSCFG_lan_ifname=`syscfg get lan_ifname`
   SYSCFG_guest_lan_ifname=`syscfg get guest_lan_ifname`
   DEPS=`sysevent get ${SYSCFG_lan_ifname}_ipv6_deprecated_but_valid_delegated_address`
   if [ -n "$DEPS" ] ; then
      sysevent set ${SYSCFG_lan_ifname}_ipv6_deprecated_but_valid_delegated_address
      ulog dhcpv6c info "Removed timer for deprecated but still valid address on $SYSCFG_lan_ifname"
   fi
   DEPS=`sysevent get ${SYSCFG_guest_lan_ifname}_ipv6_deprecated_but_valid_delegated_address`
   if [ -n "$DEPS" ] ; then
      sysevent set ${SYSCFG_guest_lan_ifname}_ipv6_deprecated_but_valid_delegated_address
      ulog dhcpv6c info "Removed timer for deprecated but still valid address on $SYSCFG_guest_lan_ifname"
   fi
