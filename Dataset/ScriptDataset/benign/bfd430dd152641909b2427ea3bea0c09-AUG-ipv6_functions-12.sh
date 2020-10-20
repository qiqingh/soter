   LAN_IPADDR=`ip -6 addr show dev lo scope global | grep inet6 | awk '{ print $2}'`
   if [ "" != "$LAN_IPADDR" ] ; then
      ip -6 addr del $LAN_IPADDR dev lo 
      echo "ip -6 addr del $LAN_IPADDR dev lo" > /dev/console
   else
      echo "lo global address not available to delete" > /dev/console
   fi
