   REPEATER_DISABLED=`syscfg get repeater_disabled`
   if [ -n "$REPEATER_DISABLED" ] && [ "1" = "$REPEATER_DISABLED" ]; then
      ulog guest_lan status "Repeater disabled. service not start"
      sysevent set ${SERVICE_NAME}-errinfo "Repeater disabled. service not started"
      sysevent set ${SERVICE_NAME}-status stopped
      return
   fi
   if [ "0" = "$SYSCFG_guest_enabled" ] ; then
      sysevent set guest_lan-status disabled
      return
   fi
   if [ "down" = "$SYSCFG_wl0_state" ] ; then	
      ulog guest_lan status "guest net is not starting since 2.4 GHz wifi is disabled"
      sysevent set guest_lan-status stopped
      return
   fi
   if [ ! -z "$SYSCFG_extender_radio_mode" -a "1" = "$SYSCFG_extender_radio_mode" ] ; then
      echo "Guest LAN is not supported on 5GHz wifi Extender" > /dev/console
      return
   fi
   wait_till_end_state ${SERVICE_NAME}
   wait_till_end_state guest_access
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] ; then
      sysevent set ${SERVICE_NAME}-status starting
      do_start
      ERR=$?
      if [ "$ERR" -ne "0" ] ; then
         check_err $? "Unable to bringup guest lan"
      else
         sysevent set ${SERVICE_NAME}-errinfo
         sysevent set ${SERVICE_NAME}-status started
      fi
   fi
   STATUS=`sysevent get guest_access-status`
   if [ "stopped" = "$STATUS" ]; then
      sysevent set guest_access-start
   fi
