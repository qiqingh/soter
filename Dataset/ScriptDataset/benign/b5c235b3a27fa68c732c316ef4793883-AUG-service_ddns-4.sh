   TO_WAIT=1
   while [ $TO_WAIT -gt 0 ]; do
      sleep $TO_WAIT
      WAN_IFNAME=`sysevent get current_wan_ifname`
      if [ -z $WAN_IFNAME ]; then
         TO_WAIT=`expr $TO_WAIT + 1`
         TO_WAIT=`expr $TO_WAIT % 5`
      else
         TO_WAIT=0
         ulog ddns status "$PID wan interface name is set: $WAN_IFNAME"
      fi
   done
