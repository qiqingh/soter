  wait_till_end_state ${SERVICE_NAME}
  STATUS=`sysevent get ${SERVICE_NAME}-status`
  if [ "stopped" != "$STATUS" ] ; then
    sysevent set ${SERVICE_NAME}-errinfo 
    sysevent set ${SERVICE_NAME}-status stopping
    
    echo "Stoppping ${SERVICE_NAME} ..."
    killall -9 smbd &> /dev/null
    killall -9 nmbd &> /dev/null
    sleep 1
    
    service_pre_halt
    
    check_err $? "Couldnt handle stop"
    sysevent set ${SERVICE_NAME}-status stopped
  else
    check_bridge_mode
    start_nmbd
  fi
  sysevent set ${SERVICE_NAME}-isready no
