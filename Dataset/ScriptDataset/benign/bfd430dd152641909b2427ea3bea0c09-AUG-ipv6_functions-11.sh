   SYSCFG_guest_lan_ifname=`syscfg get guest_lan_ifname`
   LAN_IPADDR=`ip -6 addr show dev $SYSCFG_guest_lan_ifname scope global | grep inet6 | awk '{ print $2}'`
   if [ "" != "$LAN_IPADDR" ] ; then
      ip -6 addr del $LAN_IPADDR dev $SYSCFG_guest_lan_ifname
      echo "ip -6 addr del $LAN_IPADDR dev $SYSCFG_guest_lan_ifname" > /dev/console
   else
      echo "${SYSCFG_guest_lan_ifname} global address not available to delete" > /dev/console
   fi
