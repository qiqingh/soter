   if [ -z "$1" ] ; then
      ulog dhcpv6c status "$SELF called make_dhcpv6c_duid with no parameter. Ignoring."
      return
   fi
   DUID_TYPE="00:02:"
   MANUFACTURER_IANA_PRIVATE_ENTERPRISE_NUMBER="03:09:05:05:"
   BRIDGE_MAC=`ifconfig $SYSCFG_lan_ifname | grep HWaddr | awk '{print $5}'`
   if [ -n "$1" ] ; then
      syscfg set $1 ${DUID_TYPE}${MANUFACTURER_IANA_PRIVATE_ENTERPRISE_NUMBER}${BRIDGE_MAC}
      syscfg commit
   fi
