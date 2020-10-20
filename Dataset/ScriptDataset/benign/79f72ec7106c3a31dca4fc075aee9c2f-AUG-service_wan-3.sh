   STATUS=`sysevent get wan_status_monitor_installed`
   if [ "yes" = "$STATUS" ] ; then
      return 0
   fi
   NUM=`syscfg get max_wan_count`
   if [ -z "$NUM" ] ; then 
      NUM=1
   fi
   COUNT=1
   while [ "$COUNT" -le "$NUM" ] ; do
      sysevent async wan_${COUNT}-status $WAN_STATUS_MONITOR_HANDLER
      sysevent setoptions wan_${COUNT}-status $TUPLE_FLAG_EVENT
      ulog wan status "$PID starting wan_status monitoring for wan_${COUNT}-status"
      WAN_PROTO=`syscfg get wan_${COUNT} wan_proto`
      if [ "legacy" = "$WAN_PROTO" ] ; then
         WAN_PROTO=`syscfg get wan_proto`
      fi
      COUNT=`expr $COUNT + 1`
   done
   sysevent set wan_status_monitor_installed yes
