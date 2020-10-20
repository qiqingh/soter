   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "stopped" != "$STATUS" ] 
   then
      sysevent set ${SERVICE_NAME}-errinfo 
      sysevent set ${SERVICE_NAME}-status stopping
      HAS_NA=`sysevent get ${WAN_INTERFACE_NAME}_dhcpv6_ia_na`
      HAS_PD=`sysevent get ipv6_delegated_prefix`
      if [ -f $LEASES_FILE ] && [ -n "$HAS_NA" -o -n "$HAS_PD" ] ; then
         if [ -n "$HAS_PD" ] ; then
	        PD_FLAG=" -P "
	     else
	        PD_FLAG=""
	     fi
	     if [ -n "$HAS_NA" ] ; then
	        NA_FLAG=" -N "
	     else
	        NA_FLAG=""
	     fi
         $DHCPV6_BINARY -6 -r $PD_FLAG $NA_FLAG -lf $LEASES_FILE -cf $DHCPV6_CONF_FILE $WAN_INTERFACE_NAME & >> $LOG 2>&1
      fi
      if [ -n "$DHCPV6_CLIENT_ACCEPT_INCOMPLETE_LEASE" ] ; then
         remove_dhcpv6_check_progress_script
      fi
      sleep 2
      killall dhclient
      echo -n > $DHCPV6_CONF_FILE
      rm -f $LEASES_FILE
      sysevent set wan_dhcpv6_lease
      
      sysevent set ${SERVICE_NAME}-status stopped
   fi
