   HEARTBEAT_INTERVAL=$(syscfg get routerstatus::heartbeat_interval)
   if [ -z "$HEARTBEAT_INTERVAL" ]; then
      HEARTBEAT_INTERVAL=0
      syscfg set routerstatus::heartbeat_interval $HEARTBEAT_INTERVAL
   fi
