   ulog ${SERVICE_NAME} status "${SERVICE_NAME} service_stop called"
   if [ -n "`$_PID`" ]; then
      wait_till_end_state ${SERVICE_NAME}
      if [ "started" != "`$_STATUS`" ]; then
          ulog ${SERVICE_NAME} status "${SERVICE_NAME} not started. Cannot stop."
          return 1;
      fi
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} service is being stopped"
      sysevent set ${SERVICE_NAME}-status "stopping"
      wait_till_end_state ${SERVICE_NAME}
      if [ "stopping" == "`$_STATUS`" ]; then
         ulog ${SERVICE_NAME} status "${SERVICE_NAME} did not stop in time.  Killing via kill -9"
         service_kill
      fi
   fi
   rm -f $PID_FILE
   $PMON unsetproc ${SERVICE_NAME}
