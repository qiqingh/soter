   RET_CODE=0
   if [ $SYSCFG_ddns_service = "tzo" ] ; then
      prepare_tzoupdate_config_file 
      RET_CODE=$?
   else
      if [ "" = "$SYSCFG_ddns_service" ] ; then
      	SYSCFG_ddns_service=dyndns   
      fi
      sleep 3
      DYNDNS_ADDR=`ipcheck_dyndns`
      if [ -n "$DYNDNS_ADDR" ]; then
         prepare_ezipupdate_config_file "$DYNDNS_ADDR"
         RET_CODE=$?
      fi   
   fi
   return $RET_CODE
