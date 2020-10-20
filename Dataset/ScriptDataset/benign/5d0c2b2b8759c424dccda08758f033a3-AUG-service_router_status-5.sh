   if [ "$(sysevent get fwup_state)" != "5" ]; then
      local count=$(sysevent get heartbeat_tick_count)
      count=$(expr $count + 1)
      if [ $count -ge $HEARTBEAT_INTERVAL ]; then
         count=0  
         send_event HEART_BEAT
      fi
      sysevent set heartbeat_tick_count $count
   fi
