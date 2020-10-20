   CHOSEN_IPv6_ADDRESS=
   CHOSEN_TIME=0
   CURRENT_PROVISIONED_ADDRESS=`sysevent get current_wan_ipv6address`"/64"
   ADDRS=`ip -6 -o -d addr show dev $INTERFACE > /tmp/out`
   grep global /tmp/out > /tmp/out2
   while read ln ; do
      IPv6_ADDRESS=`echo $ln | cut -f4 -d ' '`
      ADDR="$ln"
      TIME=`echo "$ADDR" | grep -o 'preferred_lft .*' | cut -f2 -d ' '`
      if [ "$CURRENT_PROVISIONED_ADDRESS" = "$IPv6_ADDRESS" ] ; then
          sysevent set preferred_time_slaac $TIME
      fi
      if [ "forever" = "$TIME" ] ; then
         if [ "forever" != "$CHOSEN_TIME" -o "$IPv6_ADDRESS" = "$CURRENT_PROVISIONED_ADDRESS" ] ; then
            CHOSEN_TIME="forever"
            CHOSEN_IPv6_ADDRESS=$IPv6_ADDRESS
         fi
      elif [ "$CHOSEN_TIME" != "forever" ] ; then
         SECS=`echo $TIME | cut -f1 -d's'`
         if [ "$SECS" -gt "$CHOSEN_TIME" ] ; then
            CHOSEN_TIME=$SECS
            CHOSEN_IPv6_ADDRESS=`echo $IPv6_ADDRESS | cut -f1 -d'/'`
         fi
      fi
   done < /tmp/out2
