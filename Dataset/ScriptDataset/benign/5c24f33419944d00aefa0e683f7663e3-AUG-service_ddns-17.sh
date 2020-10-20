   TO_WAIT=30
   ulog ddns status "$PID ipcheck_dyndns ENTER"
   echo > $OUTPUT_FILE
   wget -q http://checkip.dyndns.com/ -O ${OUTPUT_FILE} &
   WGET_PID=$!
   
   while [ $TO_WAIT -gt 0 ]; do
      if ! kill -s CONT $WGET_PID ; then
         break
      fi
      sleep 1
      TO_WAIT=`expr $TO_WAIT - 1`
   done
      
   if [ ! -z "`ps | grep [c]heckip`" ]; then
      ulog ddns status "$PID killing sleeping wget ($WGET_PID)"
      kill -9 $WGET_PID &> /dev/null
   fi
   
   DynDnsAddr=`cat ${OUTPUT_FILE} | sed -e 's/.*Current IP Address: //'| sed -e 's/<.*//'`
   ulog ddns status "$PID ddns dyndns ipcheck got [${DynDnsAddr}]"
   if [ -z "$DynDnsAddr" ]; then
      ulog ddns status "ddns warning unexpected return from checkip.dyndns.com [`cat ${OUTPUT_FILE}`]"
      set_retry_soon 10
      reset_non_fatal_ddns_status error-connect "Failed to retreive remote ip address from checkip.dyndns.com"
   fi
   echo ${DynDnsAddr}
