   if [ -f /var/run/IGD.pid ]; then
	   kill `cat /var/run/IGD.pid`
	   for n in `seq 1 6`; do
		   kill -CONT `cat /var/run/IGD.pid` > /dev/null 2>&1 && sleep 1
	   done
   fi
   killall IGD > /dev/null 2>&1
   rm -f /var/run/IGD.pid
   rm -rf /var/IGD
   unregister_monitor 
