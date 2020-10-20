   ulimit -s 2048
	IGD_START_ONCE=`sysevent get igd_start_once`
	if [ "started" != "$IGD_START_ONCE" ]; then
		sleep 30
		sysevent set igd_start_once started
	fi
   $IGD &
   echo $! > /var/run/IGD.pid
   register_monitor 50 90
   sysevent set ${SERVICE_NAME}-errinfo
   sysevent set ${SERVICE_NAME}-status "started"
