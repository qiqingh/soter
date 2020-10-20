   MUST_WAIT=11
   LAST_FAIL_TIME=`syscfg get ddns_failure_time`
   if [ "" != "$LAST_FAIL_TIME" ] ; then
      NOW=`get_current_time`
      DELTA_DAYS=`delta_days $LAST_FAIL_TIME $NOW`
      DELTA=`delta_mins $LAST_FAIL_TIME $NOW`
      
      if [ "$DELTA_DAYS" -gt "0" ]; then
         X=`expr $DELTA_DAYS \* 1440`
         Y=`expr $DELTA + $X`
         DELTA=$Y
      fi
      ulog ddns status "$PID validating quiet period [$NOW, $LAST_FAIL_TIME, $DELTA, $DELTA_DAYS]"
      if [ -n "$DELTA" ] ; then
         if [ $DELTA -ge 0 ] ; then
           if [ $MUST_WAIT -gt $DELTA ] ; then
            ulog ddns status "$PID ddns update required but we are in a quiet period. Will retry later"
            sysevent set ${SERVICE_NAME}-errinfo "mandated quiet period"
            sysevent set ${SERVICE_NAME}-status error
            
            MUST_WAIT=`expr $MUST_WAIT - $DELTA`
            MUST_WAIT=`expr $MUST_WAIT + 1`
	    set_retry_later $MUST_WAIT
            
            return 1
           else 
            syscfg unset ddns_failure_time 
           fi
         else
           ulog ddns status "$PID ddns quiet period validation is ambiguous; overwrite."
           syscfg unset ddns_failure_time 
         fi
      fi 
   fi
   return 0
