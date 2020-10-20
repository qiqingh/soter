   kill -9 $(cat $TICKER_PID_FILE)
   rm -f $TICKER_PID_FILE
   sysevent set heartbeat_tick_count
