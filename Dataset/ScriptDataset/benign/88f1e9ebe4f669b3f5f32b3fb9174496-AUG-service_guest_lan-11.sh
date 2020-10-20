  CURRENT_LAN_STATE=`sysevent get lan-status`
  if [ "started" = "$CURRENT_LAN_STATE" ] ; then
     service_start 
  elif [ "stopped" = "$CURRENT_LAN_STATE" ] ; then
     service_stop
  fi
