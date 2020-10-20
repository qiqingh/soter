#	echo "$SERVICE_NAME service_init"
	ena="`syscfg get pptpd::enabled`"
	if [ "$ena" == "1" ] ; then
	#	echo "$SERVICE_NAME running $1"
		logger "$SERVICE_NAME running $1"
	else
		if [ "$ena" == "" ] ; then
	#			echo "$SERVICE_NAME not enabled in syscfg" >> /dev/console
				exit 1
		fi
	fi
	
