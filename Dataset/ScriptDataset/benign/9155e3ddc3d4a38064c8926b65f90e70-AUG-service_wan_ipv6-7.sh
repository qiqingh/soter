   echo "service_wan_ipv6::service_stop called" >> $LOG
   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "stopped" != "$STATUS" ] ; then
      echo 0 > /proc/sys/net/ipv6/conf/all/forwarding
      ipv6_wan_down
   fi
   echo "service_wan_ipv6::service_stop done" >> $LOG
