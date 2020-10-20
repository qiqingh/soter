   local eventType=$1
   local eventVal=$2
   local output
   local rc=0
   if [ "$(sysevent get ${SERVICE_NAME}-status)" == "started" ]; then
      ulog $SERVICE_NAME status "Sending cloud event $eventType $eventVal"
      output=$(cloud_send_event_request $eventType $eventVal)
      rc=$?
      if [ $rc -ne 0 ]; then 
         eval $output
         ulog $SERVICE_NAME error "$CLOUD_ERROR_CODE $CLOUD_ERROR_DESC"
         if [ "$CLOUD_ERROR_CODE" == "NETWORK_NOT_FOUND" ]; then
            syscfg set routerstatus::heartbeat_interval 0
            syscfg commit
            sysevent set ${SERVICE_NAME}-stop
         fi
      fi
   else
      rc=3 
   fi
   return $rc
