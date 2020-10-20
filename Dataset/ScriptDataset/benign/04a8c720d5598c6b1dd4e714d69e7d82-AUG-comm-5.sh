	# construct request
	ALIAS=$1

	DATA="<?xml version=\"1.0\" encoding=\"utf-8\"?>"
	DATA="${DATA}<request moniker=\"/root/devices\" method=\"updatealias\">"
	DATA="${DATA}<body type=\"alias\">"
	DATA="${DATA}<alias>${ALIAS}</alias>"
	DATA="${DATA}</body></request>"

	comm_post "${DATA}" && {
		if [ "xSUCCESS" = "x$COMM_RESULT" ]; then
			pidof leafp2p | xargs kill -USR1
# 			$readycloud_nvram set leafp2p_device_alias="${ALIAS}"
# 			$readycloud_nvram commit >/dev/null
# 			echo "Updated Device Alias Successfully"
# 			echo ok
			return $OK
		fi
	}
	echo "Update alias error: connect to Server fail, Please check inernet connection"
	return $ERROR
