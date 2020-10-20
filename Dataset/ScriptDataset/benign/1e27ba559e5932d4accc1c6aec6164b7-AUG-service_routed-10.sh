   if [ -f "$RIPD_PID_FILE" ] ; then
      kill -TERM `cat $RIPD_PID_FILE`
      rm -f $RIPD_PID_FILE
   fi
   echo -n > $RIPD_CONF_FILE
   ulog rip status "ripd stopped"
