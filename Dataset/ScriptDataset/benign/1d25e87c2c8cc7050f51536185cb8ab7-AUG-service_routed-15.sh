   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "stopped" != "$STATUS" ] ; then
      STATUS=`sysevent get rip-status`
      if [ "stopped" != "$STATUS" ] ; then
         do_stop_ripd
         sysevent set rip-errinfo
         sysevent set rip-status stopped
      fi
      do_stop_zebra
      sysevent set ${SERVICE_NAME}-status stopped
      sysevent set ${SERVICE_NAME}-errinfo
      start_all_required_services
   fi
