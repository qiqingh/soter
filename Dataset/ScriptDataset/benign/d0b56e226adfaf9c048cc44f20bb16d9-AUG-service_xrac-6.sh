   ulog "[${SERVICE_NAME}][service_stop]"
   if is_running; then
      sysevent set ${SERVICE_NAME}-status "stopping"
      service_kill
   else  
      ulog "${SERVICE_NAME} does not appear to be running"
   fi
   sysevent set ${SERVICE_NAME}-status stopped
   sysevent set ${SERVICE_NAME}-prev_status
   rm -f $CRON_FILE
