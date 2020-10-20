	ulog ${SERVICE_NAME} status "mac filter service start"
	WIFI_SERVICE_STATUS=`sysevent get wifi_user-status`
	if [ "started" != "$WIFI_SERVICE_STATUS" ]; then
		return 0
	fi
	if [ "$CURRENT_SETTING" = "allow" ] || [ "$CURRENT_SETTING" = "deny" ]; then
		for if_name in $IF_LIST; do
			if [ "$CURRENT_SETTING" = "allow" ]; then
				iwpriv $if_name filter 1
			else
				iwpriv $if_name filter 2
			fi
			for mac in $MAC_ENTRIES; do
				macstring=`echo $mac | awk -F":" '{print $1$2$3$4$5$6}'`
			
				iwpriv $if_name filtermac "add $macstring"
			done
			iwconfig $if_name commit
		done
		sysevent set ${SERVICE_NAME}-errinfo "Succesful add MAC filter entries"
		sysevent set ${SERVICE_NAME}-status "started"
	else
		for if_name in $IF_LIST; do
			iwpriv $if_name filter 0
			iwpriv $if_name filtermac "deleteall"
			iwconfig $if_name commit
		done
		sysevent set ${SERVICE_NAME}-errinfo "MAC filter is disabled"
		sysevent set ${SERVICE_NAME}-status "started"
	fi
	return 0
