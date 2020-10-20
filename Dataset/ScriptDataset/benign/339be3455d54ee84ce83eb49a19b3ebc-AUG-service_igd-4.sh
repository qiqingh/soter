   ulimit -s 2048
   $IGD &
   echo $! > /var/run/IGD.pid
   register_monitor 50 90
   sysevent set ${SERVICE_NAME}-errinfo
   sysevent set ${SERVICE_NAME}-status "started"
