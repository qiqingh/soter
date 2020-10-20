   ulog "[${SERVICE_NAME}][check_bridgemode]"
   BRIDGE_MODE=`syscfg get bridge_mode`
   if [ "$BRIDGE_MODE" != "0" ] ; then
      ulog "XRAC cannot start when router is in bridge mode."
      service_stop
      exit 3
   fi
