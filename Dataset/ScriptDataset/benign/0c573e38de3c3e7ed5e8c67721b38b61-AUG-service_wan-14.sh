   MAX_TRIES=10
   TRIES=1
   while [ "$MAX_TRIES" -gt "$TRIES" ] ; do
      STATUS=`sysevent get ${NAMESPACE}-status`
      if [ "starting" = "$STATUS" -o "stopping" = "$STATUS" ] ; then
         ulog wan status "$PID service_stop waiting for ${NAMESPACE}-status to change from $STATUS. Try ${TRIES} of ${MAX_TRIES}"
         sleep 1
         TRIES=`expr $TRIES + 1`
      else
         TRIES=$MAX_TRIES
      fi
   done
   STATUS=`sysevent get ${NAMESPACE}-status`
   ulog wan status "$PID service_stop read state $STATUS"
   if [ "stopped" != "$STATUS" ] ; then
      ipv4_wan_down $NAMESPACE
   fi
