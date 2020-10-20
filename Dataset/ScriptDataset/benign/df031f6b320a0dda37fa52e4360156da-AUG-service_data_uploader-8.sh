   local errorInfo
   wait_till_end_state ${SERVICE_NAME}
   if [ "$(sysevent get ${SERVICE_NAME}-status)" == "started" ]; then
      return
   fi
   sysevent set ${SERVICE_NAME}-status "starting"
   local start=false
   local linksys_token=$(syscfg get device::linksys_token)
   if [ -n "$linksys_token" ]; then
         start=true
   else
      cloud_register
      if [ $? -eq 0 ]; then
         start=true
      else
         errorInfo="$CLOUD_ERROR_CODE $CLOUD_ERROR_DESC"
         retry_start_later
      fi
   fi
   if [ $start == true ]; then
      configure_cron_jobs
      rm -f $RETRY_START_FILENAME
      echo "${SERVICE_NAME} service started" >> /dev/console
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} service started" 
      sysevent set ${SERVICE_NAME}-errinfo
      sysevent set ${SERVICE_NAME}-status "started"
   else
      sysevent set ${SERVICE_NAME}-errinfo "$errorInfo"
      sysevent set ${SERVICE_NAME}-status "error"
   fi
