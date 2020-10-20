   ulog $SERVICE_NAME status "$PID provision_firewall ($DMZ_HOST_IPADDR) -ENTER"
   check_firewall_rules $DMZ_HOST_IPADDR
   RET=$?
   if [ "$RET" == "0" ]; then
      ulog $SERVICE_NAME status "$PID provision_firewall is needed"
      sysevent set firewall-restart
   fi
   ulog $SERVICE_NAME status "$PID provision_firewall () -EXIT"
