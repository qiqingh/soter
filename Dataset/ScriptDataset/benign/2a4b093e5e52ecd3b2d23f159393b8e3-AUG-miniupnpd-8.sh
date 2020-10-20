	if [ -z $1 ]; then
        	runpid=`pidof miniupnpd`
        	echo "Kill miniupnpd $runpid" > /dev/console

        	for pid in $runpid;
        	do
        	        kill -15 $pid
        	done
        	rm -f /var/run/miniupnpd.*
        else
                echo "Kill miniupnpd $1" > /dev/console
                runpid=`cat /var/run/miniupnpd.$1`
                kill -15 $runpid
                rm -f /var/run/miniupnpd.$1
	fi
