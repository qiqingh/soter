   ulog "[${SERVICE_NAME}][service_start] $2"
   ulog "[${SERVICE_NAME}][service_start] [dhcp_server-status:`sysevent get dhcp_server-status`]"
   check_ondemand
   if is_running; then
      ulog "${SERVICE_NAME} is already running"
   else
      sysevent set ${SERVICE_NAME}-status "starting"
      if [ -z $ITERATION ]; then 
        $SERVICE_FILE &
      else
        $SERVICE_FILE --retry $ITERATION &
      fi
      echo "$!" > $PID_FILE
      ulog "$! written into $PID_FILE"
      MODE=$(syscfg get smart_mode::mode)
      if [ -z "$MODE" ] || [ "$MODE" == "$MASTER_MODE" ]; then
         schedule_service_check
      fi
   fi
