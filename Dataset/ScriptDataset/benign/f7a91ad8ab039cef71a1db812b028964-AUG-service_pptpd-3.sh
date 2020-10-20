	mkdir -p `dirname "$CONF_FILE"`
	LOCAL_IP="`syscfg get pptpd::localip`"
	if [ ! "$LOCAL_IP" ] ; then
		LOCAL_IP="$dfc_localip"
#		echo "$SERVICE_NAME using default localip $LOCAL_IP"
		syscfg set pptpd::localip "$LOCAL_IP"
	fi
	echo "localip $LOCAL_IP" > $CONF_FILE
	echo "" >> $CONF_FILE
	
	REMOTE_IP="`syscfg get pptpd::remoteip`"
	END_RANGE="254"
	if [ ! "$REMOTE_IP" ] ; then
		REMOTE_IP="$dfc_remoteip"
#		echo "$SERVICE_NAME using default remoteip $REMOTE_IP"
		syscfg set pptpd::remoteip "${REMOTE_IP}"
	else
		logger "$SERVICE_NAME using remoteip $REMOTE_IP"
	fi
	LAST_OCTET=$(get_last_octet $REMOTE_IP)
	END_RANGE="`expr $LAST_OCTET + 10`"
	if [ "$END_RANGE" -gt "254" ] ; then
		END_RANGE="254"
	fi
	echo "remoteip ${REMOTE_IP}-${END_RANGE}" >> $CONF_FILE
	# echo "$SERVICE_NAME conf file created" >> /dev/console
