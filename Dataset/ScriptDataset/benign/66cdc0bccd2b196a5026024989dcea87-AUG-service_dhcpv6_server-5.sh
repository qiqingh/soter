   if [ -z "$SYSCFG_dhcpv6s_enable" ] || [ "$SYSCFG_dhcpv6s_enable" = "0" ]
   then
	echo "$SELF: DHCPv6 server cannot start because it is disabled" >> $LOG
      	sysevent set ${SERVICE_NAME}-errinfo "Cannot start: disabled"
	return
   fi
   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] 
   then
      if [ "$LAN_STATE" != "started" ]
      then
	echo "$SELF: DHCPv6 server cannot start LAN=$LAN_STATE" >> $LOG
      	sysevent set ${SERVICE_NAME}-errinfo "Cannot start LAN=$LAN_STATE"
      	sysevent set ${SERVICE_NAME}-status stopped
	return
      fi
      sysevent set ${SERVICE_NAME}-errinfo 
      sysevent set ${SERVICE_NAME}-status starting
      echo "$SELF: Starting dhcpv6 server on LAN ($LAN_INTERFACE_NAME) event=$EVENT" >> $LOG
      restore_dhcpv6s_duid
      prepare_dhcpv6s_config
      if [ "$CONFIG_EMPTY" = "no" ]
      then
	      $DHCPV6_BINARY -P $DHCPV6_PID_FILE $LAN_INTERFACE_NAME >> $LOG 2>&1
	      check_err $? "Couldnt handle start"
	      sysevent set ${SERVICE_NAME}-status started
      else
	      sysevent set ${SERVICE_NAME}-errinfo "Nothing to announce with DHCPv6"
	      sysevent set ${SERVICE_NAME}-status stopped
      fi
   fi
