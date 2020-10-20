   if [ "0" = "$SYSCFG_autofwup_enabled" ] ; then
      sysevent set autofwup-status disabled
      return 0
   fi
   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] ; then
      ERR=$?
      if [ "$ERR" -ne "0" ] ; then
         check_err $? "Unable to bringup auto firmware update"
      else
         sysevent set ${SERVICE_NAME}-errinfo
         sysevent set ${SERVICE_NAME}-status started
      fi
   fi
