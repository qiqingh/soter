   wait_till_end_state lan
   STATUS=`sysevent get lan-status`
   if [ "started" != "$STATUS" ] ; then
      do_start
      ERR=$?
      if [ "$ERR" -ne "0" ] ; then
         check_err $? "Unable to bringup bridge"
      else
         sysevent set system_state-normal
      fi
   fi
