  wait_till_end_state ${SERVICE_NAME}
  service_init
  STATUS=`sysevent get ${SERVICE_NAME}-status`
  if [ "started" != "$STATUS" ] ; then
    sysevent set ${SERVICE_NAME}-errinfo 
    sysevent set ${SERVICE_NAME}-status starting
    
    echo "Starting ${SERVICE_NAME} ... "
    $SMB_SERVER &
    if [ "$BRIDGE_MODE" == "0" ] ; then
      $NMB_SERVER &
    fi
    check_err $? "Couldnt handle start"
    sysevent set ${SERVICE_NAME}-status started
  else
    check_bridge_mode
    start_nmbd
  fi
  sysevent set ${SERVICE_NAME}-isready yes
