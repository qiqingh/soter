   DETECTED=$1
   ulog $SERVICE_NAME status "$PID check_detected ($DETECTED) -ENTER"
   check_pre_conditions
   RET=$?
   
   if [ "$RET" == "1" ]; then
      if [ "$DETECTED" == "$DMZ_HOST_IPADDR" ]; then
         provision_firewall
      else
         ulog $SERVICE_NAME status "$PID check_detected () firewall provisionning is not needed"        
      fi
   fi
   ulog $SERVICE_NAME status "$PID check_detected () -EXIT"
