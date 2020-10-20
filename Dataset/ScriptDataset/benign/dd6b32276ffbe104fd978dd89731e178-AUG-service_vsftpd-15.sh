   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] ; then
      service_init
      FTP_ENA=`syscfg get ftp_enabled`
      if [ "$FTP_ENA" == "1" ] ; then
        sysevent set ${SERVICE_NAME}-errinfo 
        sysevent set ${SERVICE_NAME}-status starting
        echo "Starting ${SERVICE_NAME} ... "
        $FTP_SERVER &
        
        check_err $? "Couldnt handle start"
        sysevent set ${SERVICE_NAME}-status started
      fi
   fi
