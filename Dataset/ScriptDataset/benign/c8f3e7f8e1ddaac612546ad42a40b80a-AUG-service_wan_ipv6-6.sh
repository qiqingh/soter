   echo "service_wan_ipv6::service_start called" >> $LOG
   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] ; then
      echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
      ipv6_wan_up
   fi
   echo "service_wan_ipv6::service_start done" >> $LOG
