   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "stopped" != "$STATUS" ] ; then
      do_stop_radvd
      sysevent set ${SERVICE_NAME}-status stopped
      sysevent set ${SERVICE_NAME}-errinfo
      start_all_required_services
   fi
