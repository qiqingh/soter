   FIREWALL_STATE=`sysevent get firewall-status`
   get_dmz_host
   RET=$?
   
   if [ "$RET" == "0" ]; then
      ulog $SERVICE_NAME warning "$PID DMZ is disabled. stop the dmz listener"
      service_stop
      return 0
   fi
   
   if [ "$FIREWALL_STATE" == "started" ] ; then
      return 1
   else   
      ulog $SERVICE_NAME warning "$PID check_pre_conditions not met ($FIREWALL_STATE,$RET)"
   fi
   return 0
