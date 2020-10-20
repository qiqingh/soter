	INTERFACE=$1
	SSID=$2
	AP_SCAN_FILE=/tmp/ap_scan.txt
	RSN=""
	WPA=""
	RETURN=""
	
	wl -i $INTERFACE up
	wl -i $INTERFACE scan $SSID
	sleep 2
	wl -i $INTERFACE scanresults > $AP_SCAN_FILE
	RSN=`cat $AP_SCAN_FILE | grep "RSN:"`
	WPA=`cat $AP_SCAN_FILE | grep "WPA:"`
	FILESIZE=`stat -c %s $AP_SCAN_FILE`
	if [ $FILESIZE -eq 0 ]; then
		echo "failed"
		return
	fi
	if [ -z "$RSN" ] && [ -z "$WPA" ]; then
		RETURN="open"
	else
		if [ -n "$RSN" ]; then
			RETURN="wpa2-personal"
		else
			RETURN="wpa-personal"
		fi
	fi
	echo "$RETURN"
