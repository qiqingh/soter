   PRIORERROR=`sysevent get ddns_return_status`
   case "$PRIORERROR" in
      error-connect|error|unknown)
         sysevent set ddns_return_status
         sysevent set ${SERVICE_NAME}-errinfo
         ;;
      esac
