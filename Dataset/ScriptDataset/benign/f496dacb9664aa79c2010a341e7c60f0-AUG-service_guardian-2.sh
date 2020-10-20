   ulog ${SERVICE_NAME} status "${SERVICE_NAME} service_start called"
   if [ "`syscfg get bridge_mode`" != "0" ]; then		# "1" or "2"
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} service should not start in bridge mode"
      return 1;
   fi
   wait_till_end_state ${SERVICE_NAME}
   if [ "stopped" != "`$_STATUS`" ]; then
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} not stopped. Cannot start."
      return 1;
   fi
   if [ -z "`$_PID`" ]; then
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} service starting"
      sysevent set ${SERVICE_NAME}-status "starting"
      ulimit -s 2048
      nice -n -10 ${APP} &
      wait_till_end_state ${SERVICE_NAME}
      if [ "starting" == "`$_STATUS`" ]; then
         ulog ${SERVICE_NAME} status "${SERVICE_NAME} did not start in time.  Killing via kill -9"
         service_kill
         return 1
      fi
   fi
   echo "`$_PID`" > $PID_FILE
   $PMON setproc ${SERVICE_NAME} $BIN $PID_FILE "/etc/init.d/service_${SERVICE_NAME}.sh ${SERVICE_NAME}-restart"
