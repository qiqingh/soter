   if [ -f $PID_FILE ]; then
      kill -9 $(cat $PID_FILE) > /dev/null 2>&1
      rm -f $PID_FILE
   fi
