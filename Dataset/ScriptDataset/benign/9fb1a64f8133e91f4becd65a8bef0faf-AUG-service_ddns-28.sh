   RET_CODE=
   if [ $SYSCFG_ddns_service = "tzo" ] ; then
      update_tzo_server
      RET_CODE=$?
   elif [ $SYSCFG_ddns_service = "noip" ] ; then
      update_noip_server
      RET_CODE=$?
   else
      if [ "" = "$SYSCFG_ddns_service" ] ; then
         SYSCFG_ddns_service=dyndns   
      fi
      update_ddns_ez_ipupdate
      RET_CODE=$?
   fi
   return $RET_CODE
