   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] ; then
      ulog system status "$PID system is starting"
      sysevent set ${SERVICE_NAME}-status starting 
      sysevent set ${SERVICE_NAME}-errinfo 
      service_init
      if [ -n "$SYSCFG_last_known_date" ] 
      then
         date -s $SYSCFG_last_known_date
      fi
      sysevent set phylink-start
      sysevent set forwarding-start
      SYSCFG_led_ui_rearport=`syscfg get led_ui_rearport`
      if [ "$SYSCFG_led_ui_rearport" != "0" ] ; then
         sysevent set led_ethernet_on
      else
         sysevent set led_ethernet_off	  
      fi
      
      sysevent set ${SERVICE_NAME}-status started 
      ulog system status "$PID system is started"
   fi
