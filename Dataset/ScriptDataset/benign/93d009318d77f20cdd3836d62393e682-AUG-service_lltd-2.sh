   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "stopped" != "$STATUS" ] ; then
      sysevent set ${SERVICE_NAME}-status stopping
      killall lld2d > /dev/null 2>&1
      ulog ${SERVICE_NAME} status "stop."
      
      check_err $? "Couldnt handle stop"
      sysevent set ${SERVICE_NAME}-status stopped
   fi
