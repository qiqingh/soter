   if [ -f "$ZEBRA_PID_FILE" ] ; then
      kill -TERM `cat $ZEBRA_PID_FILE`
      rm -f $ZEBRA_PID_FILE
   fi
   echo -n > $ZEBRA_CONF_FILE
   ulog routed status "zebra stopped"
