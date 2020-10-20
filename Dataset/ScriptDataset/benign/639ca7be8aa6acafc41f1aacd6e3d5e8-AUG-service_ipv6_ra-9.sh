   if [ -f "$RADVD_PID_FILE" ] ; then
      make_radvd_conf_file
      kill -SIGHUP `cat $RADVD_PID_FILE` >> $LOG 2>&1
      if [ "1" = "$?" ] ; then
         echo "$SELF do_start_radvd" >> $LOG
         do_start_radvd
      fi
      clean_cron_retry_file
      make_cron_retry_file
   fi
