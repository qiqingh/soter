   get_ethernet_port $1
   if [ "0" = "$PORT" ] ; then
      return 0
   fi
   TAG=`et robord 0x34 $PORT`
   VLAN=`echo "$TAG" | awk '{print substr($0,4,4)}'`
   et robowr 0x34 $PORT 0x`printf "%01x" $2`${VLAN}
