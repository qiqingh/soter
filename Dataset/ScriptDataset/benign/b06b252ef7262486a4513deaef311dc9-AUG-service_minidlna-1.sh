	echo "$SERVICE_NAME service_init"
	supp="`syscfg get MediaServer::mediaServerSupport`"
	if [ "$supp" == "0" ] ; then
		echo "$SERVICE_NAME not support" >> /dev/console
		exit 1
	fi
	ena="`syscfg get MediaServer::mediaServerEnable`"
	if [ "$ena" == "1" ] ; then
		echo "$SERVICE_NAME running $1" >> /dev/console
	else
		echo "$SERVICE_NAME not enabled in syscfg" >> /dev/console
		exit 1
	fi
	if [ ! -d "$CFGDIR" ]; then
		mkdir -p "$CFGDIR"
	fi
