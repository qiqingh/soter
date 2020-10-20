   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "stopped" != "$STATUS" ] ; then
      sysevent set ${SERVICE_NAME}-errinfo 
      sysevent set ${SERVICE_NAME}-status stopping
      MINIDLNA_PID="`cat /var/run/minidlna/minidlna.pid`"
      kill -INT $MINIDLNA_PID 
      check_err $? "Couldnt handle stop"
      sleep 3
      killall -9 minidlnad > /dev/null 2>&1
      sysevent set ${SERVICE_NAME}-status stopped
   fi
