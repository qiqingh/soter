   NEW_STATUS=$1
   NEW_INFO=$2
   ulog ddns status "$PID reset_non_fatal_ddns_status (${NEW_STATUS},${NEW_INFO})"
   PRIORERROR=`sysevent get ddns_return_status`
   case "$PRIORERROR" in
      error-hostname|error-auth|error-abuse)
      ;;
      *)
         sysevent set ddns_return_status "$NEW_STATUS"
         sysevent set ${SERVICE_NAME}-errinfo "$NEW_INFO"
         ;;
      esac
