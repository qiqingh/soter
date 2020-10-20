   wait_till_end_state ${SERVICE_NAME}
   local networkId=$(syscfg get owned_network_id)
   if [ "$(sysevent get ${SERVICE_NAME}-status)" != "started" ] && [ $HEARTBEAT_INTERVAL -gt 0 ] && 
        [ -n "$networkId" ] && [ "$(sysevent get wan-status)" == "started" ]; then
      sysevent set ${SERVICE_NAME}-status "starting"
      start_ticker
      echo "${SERVICE_NAME} service started" >> /dev/console
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} service started" 
      sysevent set ${SERVICE_NAME}-errinfo
      sysevent set ${SERVICE_NAME}-status "started"
   else
      ulog ${SERVICE_NAME} status "Could not start ${SERVICE_NAME}" 
   fi
