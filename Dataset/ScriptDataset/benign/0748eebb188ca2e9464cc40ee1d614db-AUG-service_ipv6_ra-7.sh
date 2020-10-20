   clean_cron_retry_file
   if [ -f "$RADVD_PID_FILE" ] ; then
      kill -TERM `cat $RADVD_PID_FILE`
      rm -f $RADVD_PID_FILE
   fi
   ulog routed status "radvd stopped"
