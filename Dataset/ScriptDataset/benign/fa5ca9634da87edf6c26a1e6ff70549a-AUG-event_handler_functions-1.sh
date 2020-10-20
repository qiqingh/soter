   if [ "${1}" -ne "0" ] ; then
      ulog $SERVICE_NAME status "PID ($$) Error ($1) $2"
      sysevent set ${SERVICE_NAME}-status error
      sysevent set ${SERVICE_NAME}-errinfo "Error ($1) $2"
   fi
