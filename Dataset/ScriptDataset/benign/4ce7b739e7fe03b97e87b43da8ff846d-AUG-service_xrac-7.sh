   ulog "[${SERVICE_NAME}][check_ondemand]"
   PPP_PROTO=`syscfg get wan_proto|grep -E "l2tp|ppoe|pptp"`
   PPP_MODE=`syscfg get ppp_conn_method`
   if [ "demand" = "$PPP_MODE" ] && [ $PPP_PROTO ] ; then
      ulog "XRAC cannot start if ppp_conn_method is on demand."
      service_stop
      exit 3
   fi
