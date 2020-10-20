   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" = "$STATUS" -a -f "$RADVD_PID_FILE" ] ; then
      echo "$SELF do_reload_radvd" >> $LOG
      do_reload_radvd
   else
      echo "$SELF do_start_radvd" >> $LOG
      do_start_radvd
   fi
