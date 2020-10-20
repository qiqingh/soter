   EFFECTIVE_WAN_IPADDR=`get_effective_wan_ipaddr`
   PRIORERROR=
   
   case "$EFFECTIVE_WAN_IPADDR" in
      0.0.0.0)
        ulog ddns status "$PID wan state is down. No ddns update possible"
        sysevent set ${SERVICE_NAME}-errinfo "wan is down. No update possible"
       
        reset_non_fatal_ddns_status error-connect "wan interface is down"
        sysevent set ${SERVICE_NAME}-status error
        stop_tzo_polling
        ;;
   *)
      ddns_state_restore
      clear_all_retry_soon
      
      if [ -z $WAN_IFNAME ]; then
            ulog ddns status "$PID wan interface is flacking ; need to wait a bit"
            wait_for_wan_ifname
      fi
      if [ -z $WAN_IFNAME ] || [ -z $EFFECTIVE_WAN_IPADDR ]; then
         ulog ddns status "$PID wan interface is still not set; will retry soon"
         set_retry_soon 1
      else   
         is_parameter_changed
         flag=$?
         if [ "$flag" = "0" ]; then
            PRIORERROR=`sysevent get ddns_return_status`
         fi
         if [ "" = "$PRIORERROR" ] || 
            [ "success" = "$PRIORERROR" ] ||
            [ "error-server" = "$PRIORERROR" ] ||
            [ "error-connect" = "$PRIORERROR" ] ||
            [ "error-abuse" = "$PRIORERROR" ] ; then
            sleep 5 
            ulog ddns status "$PID Effective wan ip address is [$EFFECTIVE_WAN_IPADDR]. Continuing"
            do_start $flag
          else
            ulog ddns status "$PID No ddns update due to prior ddns error (${PRIORERROR})"
            sysevent set ${SERVICE_NAME}-errinfo "No update possible due to prior ddns error (${PRIORERROR})"
            sysevent set ${SERVICE_NAME}-status error
          fi
      fi
      ;;
      
   esac
