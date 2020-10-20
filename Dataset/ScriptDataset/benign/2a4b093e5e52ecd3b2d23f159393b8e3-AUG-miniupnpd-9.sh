	runpid=`pidof miniupnpd`
	echo "Send miniupnpd wan change to $runpid" > /dev/console
	for pid in $runpid;
	do
		kill -16 $pid
	done
