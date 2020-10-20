   wait_till_end_state ${SERVICE_NAME}
   if [ "$(sysevent get ${SERVICE_NAME}-status)" == "stopped" ]; then
      return
   fi
   sysevent set ${SERVICE_NAME}-status "stopping"
   stop_registration
   rm -f $TOKEN_REFRESH_CRONFILE > /dev/null 2>&1
   sysevent set ${SERVICE_NAME}-errinfo
   sysevent set ${SERVICE_NAME}-status "stopped"
   log_it status "Service stopped" 
