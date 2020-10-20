   wait_till_end_state dns
   wait_till_end_state dhcp_server
   DHCP_STATE=`sysevent get dhcp_server-status`
   DNS_STATE=`sysevent get dns-status`
   sysevent set dns-errinfo
   sysevent set dhcp_server_errinfo
   if [ "stopped" != "$DHCP_STATE" ]
   then 
      $PMON unsetproc dhcp_server
      killall -HUP `basename $SERVER`
   fi
   killall `basename $SERVER` > /dev/null 2>&1
   rm -f $PID_FILE
   if [ "stopped" != "$DHCP_STATE" ]
   then 
      sysevent set dhcp_server-status stopped
      sysevent set reboot-status dhcp-stopped
      ulog dhcp_server status "$PID reboot-status:dhcp-stopped"
   fi
   sysevent set dns-status stopped
