   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "stopped" != "$STATUS" ] 
   then
      sysevent set ${SERVICE_NAME}-errinfo 
      sysevent set ${SERVICE_NAME}-status stopping
      IPADDR_FROM_IA=`sysevent get ${WAN_INTERFACE_NAME}_dhcpv6_ia_na`
      if [ -f $LEASES_FILE -a -n "$IPADDR_FROM_IA" ] ; then
         $DHCPV6_BINARY -6 -r -lf $LEASES_FILE -cf $DHCPV6_CONF_FILE & >> $LOG 2>&1
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
