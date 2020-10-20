   MAX_TRIES=10
   TRIES=1
   while [ "$MAX_TRIES" -gt "$TRIES" ] ; do
      STATUS=`sysevent get ${NAMESPACE}-status`
      if [ "starting" = "$STATUS" -o "stopping" = "$STATUS" ] ; then
         ulog wan status "$PID service_start waiting for ${NAMESPACE}-status to change from $STATUS. Try ${TRIES} of ${MAX_TRIES}"
         sleep 1
         TRIES=`expr $TRIES + 1`
      else
         TRIES=$MAX_TRIES
      fi
   done
   STATUS=`sysevent get ${NAMESPACE}-status`
   if [ "started" != "$STATUS" ] ; then
      ipv4_wan_up $NAMESPACE
   fi