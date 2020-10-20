   PID=`pidof $WAN_BANDWIDTH_MONITOR_BIN`
   if [ -n "$PID" ] ; then
      killall $WAN_BANDWIDTH_MONITOR_BIN
   fi
