   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "stopped" != "$STATUS" ] 
   then
      sysevent set ${SERVICE_NAME}-errinfo 
      sysevent set ${SERVICE_NAME}-status stopping
      echo "$SELF: Stopping DHCPv6 Server (LAN state=$LAN_STATE, event=$EVENT)" >> $LOG
      killall dhcp6s > /dev/null 2>&1
      sysevent set ${SERVICE_NAME}-status stopped
   fi
