   ulog "[${SERVICE_NAME}][service_check] checking status"
   STATUS=$(sysevent get ${SERVICE_NAME}-status)
   if [ "$STATUS" == "started" ]; then
      ulog "[${SERVICE_NAME}][service_check] service started, so removing cron job"
      rm -f $CRON_FILE
   else
      PREV_STATUS=$(sysevent get ${SERVICE_NAME}-prev_status)
      if [ "$STATUS" == "$PREV_STATUS" ]; then
         if [ "$STATUS" == "starting" ]; then
            ulog "[${SERVICE_NAME}][service_check] WARNING: stuck in the starting state, so restarting the service" 
            service_stop
            service_start
         fi
      else
         sysevent set ${SERVICE_NAME}-prev_status $STATUS
      fi
   fi
