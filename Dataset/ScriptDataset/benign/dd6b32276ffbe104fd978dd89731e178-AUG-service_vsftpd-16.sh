  wait_till_end_state ${SERVICE_NAME}
  STATUS=`sysevent get ${SERVICE_NAME}-status`
  if [ "stopped" != "$STATUS" ] ; then
    sysevent set ${SERVICE_NAME}-errinfo 
    sysevent set ${SERVICE_NAME}-status stopping
    
    echo "Stopping ${SERVICE_NAME} ... "
    
    killall -s TERM vsftpd
    service_pre_halt
    
    check_err $? "Couldnt handle stop"
    sysevent set ${SERVICE_NAME}-status stopped
  fi
