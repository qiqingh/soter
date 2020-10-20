    # construct request
	USER_NAME=$1
	USER_PASS=$2

	DATA="<?xml version=\"1.0\" encoding=\"utf-8\"?>"
	DATA="${DATA}<request moniker=\"/root/devices\" method=\"unregister\">"
	DATA="${DATA}<body type=\"registration\">"
	DATA="${DATA}<username>${USER_NAME}</username>"
	DATA="${DATA}<password>${USER_PASS}</password>"
	DATA="${DATA}<license><LicenseKey>sdfsfgjsflkj</LicenseKey><hardwareSN>2496249</hardwareSN><StartTime>0</StartTime><ExpiredTime>999</ExpiredTime><valid>true</valid></license>"
	DATA="${DATA}</body></request>"

	comm_post "${DATA}" && {
	if [ "xSUCCESS" = "x$COMM_RESULT" ]; then
            readycloud_nvram set readycloud_registration_owner=""
            readycloud_nvram set leafp2p_run="0"
            readycloud_nvram set x_force_connection
            readycloud_nvram commit
            internet set connection readycloud 0
            return $OK
	fi
	}
	echo "Connect to Server fail, Please check inernet connection"
	return $ERROR
