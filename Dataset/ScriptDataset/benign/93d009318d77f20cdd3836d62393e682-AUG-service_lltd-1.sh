   wait_till_end_state ${SERVICE_NAME}
   BRIDGEMODE=`syscfg get bridge_mode`
   if [ "1" = "$BRIDGEMODE" ] || [ "2" = "$BRIDGEMODE" ] ; then
      ulog ${SERVICE_NAME} status "no ${SERVICE_NAME} in bridge mode."
      exit
   fi
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] ; then
       if [ "starting" != "$STATUS" ] ; then
          sysevent set ${SERVICE_NAME}-status starting
          LANIFNAME=`syscfg get lan_ifname`
          lld2d $LANIFNAME
          ulog ${SERVICE_NAME} status "start."
          check_err $? "Couldnt handle start"
          sysevent set ${SERVICE_NAME}-status started
       fi
   fi
