   ulog "[${SERVICE_NAME}][service_check] checking status"
   STATUS=$(sysevent get ${SERVICE_NAME}-status)
   if [ "$STATUS" == "starting" ]; then
      PREV_STATUS=$(sysevent get ${SERVICE_NAME}-prev_status)
      if [ "$STATUS" == "$PREV_STATUS" ]; then
         ulog "[${SERVICE_NAME}][service_check] WARNING: stuck in the starting state, so restarting the service" 
         service_stop
         service_start
      else
         sysevent set ${SERVICE_NAME}-prev_status $STATUS
      fi
   else
      ulog "[${SERVICE_NAME}][service_check] service $STATUS, so removing cron job"
      rm -f $CRON_FILE
   fi
