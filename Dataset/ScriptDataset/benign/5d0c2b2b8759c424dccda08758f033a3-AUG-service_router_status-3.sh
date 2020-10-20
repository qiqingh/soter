   sysevent set heartbeat_tick_count $HEARTBEAT_INTERVAL
   if [ ! -f "$TICKER_PID_FILE" ]; then
      local intervalPerSec=2
      local randInterval=$(expr $intervalPerSec \* $TICK_INTERVAL \* $HEARTBEAT_INTERVAL)
      local randValue=$(expr $RANDOM \% $randInterval)
      local sleepTimeMsec=$(expr $randValue \* 1000 \/ $intervalPerSec)
      /etc/init.d/router_status_ticker.sh $sleepTimeMsec $TICK_INTERVAL &
      echo $! > $TICKER_PID_FILE
   fi
