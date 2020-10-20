   ulog "[${SERVICE_NAME}][service_kill] PID:`$_PID`"
   if [ -n "`$_PID`" ]; then
      kill -9 `$_PID`;
   fi
   rm -f $PID_FILE
   sysevent set ${SERVICE_NAME}-status "stopped"
