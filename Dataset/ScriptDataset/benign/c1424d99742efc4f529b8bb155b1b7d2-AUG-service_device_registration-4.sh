   wait_till_end_state ${SERVICE_NAME}
   if [ "$(sysevent get ${SERVICE_NAME}-status)" == "started" ]; then
      return
   fi
   sysevent set ${SERVICE_NAME}-status "starting"
   sysevent set ${SERVICE_NAME}-errinfo
   if [ -z "$(syscfg get device::linksys_token)" ]; then
      ${REG_SCRIPT} register &
      echo $! > $PID_FILE
   else
      create_cron_job
   fi
   sysevent set ${SERVICE_NAME}-status "started"
   log_it status "Service started"
