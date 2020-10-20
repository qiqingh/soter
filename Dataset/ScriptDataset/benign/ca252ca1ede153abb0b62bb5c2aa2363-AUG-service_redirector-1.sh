   if [ -n "`$_PID`" ]; then
      kill -9 `$_PID`;
   fi
   sysevent set ${SERVICE_NAME}-status "stopped"
