   if [ -n "`$_PID`" ]; then
      sysevent set ${SERVICE_NAME}-status "stopping"
      killall -15 $SERVICE_NAME
      wait_till_end_state ${SERVICE_NAME}
      if [ "stopping" == "`$_STATUS`" ]; then
         service_kill
      fi
   fi
   rm -f $PID_FILE
   $PMON unsetproc ${SERVICE_NAME}
