   if [ -z "$1" ] ; then
      return 0
   fi
   
   ulog dhcpv6c status "in remove_deprecated_delegated_address"
   DEPR_ADDR=`sysevent get ${1}_ipv6_deprecated_but_valid_delegated_address`
   if [ -z "$DEPR_ADDR" ] ; then
      return 0
   fi
   ulog dhcpv6c status "remove_deprecated_delegated_address: Removing $DEPR_ADDR from $1"
   ip -6 addr del $DEPR_ADDR dev $1
   sysevent set ${1}_ipv6_deprecated_but_valid_delegated_address
