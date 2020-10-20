   DUID_TYPE="00:02:"
   MANUFACTURER_IANA_PRIVATE_ENTERPRISE_NUMBER="03:09:05:05:"
   BRIDGE_MAC_NAME=`syscfg get lan_ifname`
   BRIDGE_MAC=`ifconfig $BRIDGE_MAC_NAME | grep HWaddr | awk '{print $5}'`
   if [ -n "$1" ] ; then
      syscfg set $1 ${DUID_TYPE}${MANUFACTURER_IANA_PRIVATE_ENTERPRISE_NUMBER}${BRIDGE_MAC}
      syscfg commit
   fi
