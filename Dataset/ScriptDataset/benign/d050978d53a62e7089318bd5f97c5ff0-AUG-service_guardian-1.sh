   if [ -n "`$_PID`" ]; then
      kill -9 `$_PID`;
   fi
   /etc/guardian/unregister.sh
   sysevent set ${SERVICE_NAME}-status "stopped"
