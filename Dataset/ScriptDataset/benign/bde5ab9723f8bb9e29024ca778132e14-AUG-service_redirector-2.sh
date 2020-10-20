   if [ -z "`$_PID`" ]; then
      sysevent set ${SERVICE_NAME}-status "starting"
      ulimit -s 2048
      ${APP} &
      wait_till_end_state ${SERVICE_NAME}
      if [ "starting" == "`$_STATUS`" ]; then
         service_kill
         return 1
      fi
   fi
   echo "`$_PID`" > $PID_FILE
   $PMON setproc ${SERVICE_NAME} $BIN $PID_FILE "/etc/init.d/service_${SERVICE_NAME}.sh ${SERVICE_NAME}-restart"
