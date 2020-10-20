	# construct request
	USER_NAME=$1
	USER_PASS=$2
	temp_dir=$3
	XAGENT_ID=$(readycloud_nvram get x_agent_id)
	MODEL=$(remote_smb_conf -get_model_name)
	USE_XCLOUD=$(readycloud_nvram get readycloud_use_xcloud)

	FIRMWARE_VERSION=`version | sed -n 2p | awk -F "/" '{print $2}' | sed -r 's/^.{1}//'`
	#get second line of "version" command output
	#get second part of "U12H270T00/V1.0.3.49/20140403_xAgent" line (version)
	#and removing first character "V" from it
	#output - "1.0.3.49"

	DATA="<?xml version=\"1.0\" encoding=\"utf-8\"?>"
	DATA="${DATA}<request moniker=\"/root/devices\" method=\"register\">"
	DATA="${DATA}<body type=\"registration\">"
	DATA="${DATA}<username>${USER_NAME}</username>"
	DATA="${DATA}<password>${USER_PASS}</password>"
	DATA="${DATA}<model>${MODEL}</model>"
	DATA="${DATA}<firmware_id>${FIRMWARE_VERSION}</firmware_id>"
	if [ $USE_XCLOUD -eq 1 ]; then 
		DATA="${DATA}<x_agent_id>${XAGENT_ID}</x_agent_id>"
	fi
	DATA="${DATA}<license><LicenseKey>sdfsfgjsflkj</LicenseKey><hardwareSN>`burnsn 2>&1 | sed 's/[a-z -]//g'`</hardwareSN><StartTime>0</StartTime><ExpiredTime>999</ExpiredTime><valid>true</valid></license>"
	DATA="${DATA}</body></request>"

	comm_post "${DATA}" && {
	   if [ "xSUCCESS" = "x${COMM_RESULT}" ]; then
		readycloud_nvram set readycloud_registration_owner=${USER_NAME}
        readycloud_nvram set leafp2p_run="1"
        readycloud_nvram set x_force_connection="1"
        readycloud_nvram commit
        kill -SIGHUP `cat /tmp/xagent_watchdog.pid`

		internet set connection readycloud 1
		return $OK
	    fi
	}
	echo "Invalid User Name or Password"
	return $ERROR
