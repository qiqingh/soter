   PID=`pidof $WAN_BANDWIDTH_MONITOR_BIN`
   if [ -z "$PID" -a -f /usr/sbin/$WAN_BANDWIDTH_MONITOR_BIN ] ; then
     /usr/sbin/$WAN_BANDWIDTH_MONITOR_BIN
   fi 
