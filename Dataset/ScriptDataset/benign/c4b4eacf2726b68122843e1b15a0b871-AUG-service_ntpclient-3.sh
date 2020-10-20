   if [ -n "$SYSCFG_ntp_enabled" ] && [ "0" = "$SYSCFG_ntp_enabled" ] ; then
      return 0
   fi
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] ; then
      ulog ${SERVICE_NAME} status "check requested but ${SERVICE_NAME}-status is $STATUS" 
      return 0
   fi
   if [ "started" != "$CURRENT_WAN_STATUS" ] ; then
      ulog ${SERVICE_NAME} status "check requested but wan is down" 
      return 0
   fi
   if [ -f "$RETRY_SOON_FILENAME" ] ; then
      rm -f $RETRY_SOON_FILENAME;
   fi
   last_time="`date -u`"
   if [ -n "$last_time" ] 
   then
      last_time=`echo $last_time | cut -f 4 -d ' '`
      last_hr=`echo $last_time | cut -f 1 -d ':'`
      last_min=`echo $last_time | cut -f 2 -d ':'`
      t_hr=`expr $last_hr \* 60`
      last_min=`expr $last_min + $t_hr`
   fi
   contact_one_server
   
   if [ "" = "$RESULT" ] ; then
      if  [ ! -f "$RETRY_SOON_FILENAME" ] ; then
         NUM_ERRORS=`sysevent get ntpclient_num_errors`
         if [ -z "$NUM_ERRORS" ] ; then
            NUM_ERRORS=0
         fi
         if [ "started" = "`sysevent get ${SERVICE_NAME}-status`" -a "12" -ge "$NUM_ERRORS" ] ; then
            sysevent set ntpclient_num_errors=`expr $NUM_ERRORS + 1`
            ulog ${SERVICE_NAME} status "Unable to connect to NTP Server $NTP_SERVER. Ignoring." 
            return 0
         fi 
         sysevent set ntpclient_num_errors=`expr $NUM_ERRORS + 1`
         prepare_retry_soon_file
         sysevent set ${SERVICE_NAME}-status "error"
         sysevent set ${SERVICE_NAME}-errinfo "No result from NTP Server"
         ulog ${SERVICE_NAME} status "Unable to connect to NTP Server $NTP_SERVER. Retrying soon." 
         return 0
      else
         ulog ${SERVICE_NAME} status "Unable to connect to NTP Server $NTP_SERVER. Retry already scheduled" 
      fi
   else
      sysevent set ntpclient_num_errors=0
   fi
   sysevent set ecosystem_date `date -u +%Y%m%d%H%M.%S`
   syscfg set last_known_date `date -u +%Y%m%d%H%M`
   export TZ=$SYSCFG_TZ
   A=`date +%z`; B=`echo ${A:0:3}`; C=`echo ${A:3:2}`; Z=`echo $B:$C`
   syscfg set first_use_date `date +%FT%T$Z`
   if [ -n "$last_min" ] 
   then
      current_time=`date -u`
      current_time=`echo $current_time | cut -f 4 -d ' '`
      current_hr=`echo $current_time | cut -f 1 -d ':'`
      current_min=`echo $current_time | cut -f 2 -d ':'`
      t_hr=`expr $current_hr \* 60`
      current_min=`expr $current_min + $t_hr`
      time_delta=`expr $current_min - $last_min`
      if [ "90" -lt "$time_delta" ]
      then
         ulog ${SERVICE_NAME} status "Time skew is over 1 hour. Restarting wan" 
         syscfg commit
         sysevent set ${SERVICE_NAME}-status "stopped"
         sysevent set dhcp_client-restart
         sysevent set dhcpv6_client-restart
         sysevent set mcastproxy-restart
         sysevent set ${SERVICE_NAME}-status "started"
      fi
   fi
   if [ -n "$SYSCFG_TZ" ] ; then
      sysevent set TZ $SYSCFG_TZ
      sed  's%export setenv TZ=.*%export setenv TZ="'"$SYSCFG_TZ"'"%' /etc/profile > /tmp/ntpclient_profile
      cat /tmp/ntpclient_profile > /etc/profile
      rm -f /tmp/ntpclient_profile
   fi
