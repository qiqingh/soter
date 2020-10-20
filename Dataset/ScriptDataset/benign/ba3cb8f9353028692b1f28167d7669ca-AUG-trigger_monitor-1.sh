   PID=$$
   ulog triggers status "$PID starting trigger monitoring process"
   if [ -z `pidof trigger` ] ; then
      $TRIGGER_HANDLER
   fi
   sysevent set ${SERVICE_NAME}-status started
