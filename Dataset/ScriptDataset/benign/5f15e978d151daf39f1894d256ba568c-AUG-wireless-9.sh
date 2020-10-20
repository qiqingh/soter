    log_info "wifi" "wlanBridge_update"

    if [ $proto = "6" ]; then
        objReq wlanBridge setparam 0 enable 1
		objReq wlanBridge setparam 1 enable 1
    else
        objReq wlanBridge setparam 0 enable 0
		objReq wlanBridge setparam 1 enable 0
    fi


    json_load "$(objReq wlanBridge json)"
    json_select "WlanBridgeT"
    local Index="1"


    while json_get_type Type $Index && [ "$Type" = object ]; do
        local  ssid ifname type authtype encrypType wpaPsk

        json_select "$Index"
        json_get_vars ssid ifname type authtype encrypType wpaPsk

        log_info "wifi" "#$Index ssid:$ssid, ifname:$ifname, type:$type"
        log_info "wifi" " authtype:$authtype, encrypType:$encrypType, wpaPsk:$wpaPsk"


        local config_path
        if [ $type = "2" ]; then
            config_path=$PATH_24G
            ifname_cmd="apcli0"

        elif [ $type = "5" ]; then
            config_path=$PATH_5G
            ifname_cmd="apclii0"
        fi

        if [ $proto = "6" -a  $type = "2" ]; then
            wificonf -f $PATH_24G set ApCliEnable 1
            wificonf -f $PATH_5G  set ApCliEnable 0

        elif [ $proto = "6" -a  $type = "5" ]; then
            wificonf -f $PATH_24G set ApCliEnable 0
            wificonf -f $PATH_5G  set ApCliEnable 1
        else
            wificonf -f $PATH_24G set ApCliEnable 0
            wificonf -f $PATH_5G  set ApCliEnable 0
        fi

		WIFI_CMD_SSID=$(echo $ssid | sed 's/[$]/\$/g')
		WIFI_CMD_SSID=$(echo $WIFI_CMD_SSID | sed 's/[`]/\`/g')
		WIFI_CMD_SSID=$(echo $WIFI_CMD_SSID | sed 's/["]/\"/g')


		WIFI_CMD_WPAPSK=$(echo $wpaPsk | sed 's/[$]/\$/g')
		WIFI_CMD_WPAPSK=$(echo $WIFI_CMD_WPAPSK | sed 's/[`]/\`/g')
		WIFI_CMD_WPAPSK=$(echo $WIFI_CMD_WPAPSK | sed 's/["]/\"/g')

        wificonf -f $config_path set ApCliSsid "$WIFI_CMD_SSID"
        wificonf -f $config_path set ApCliAuthMode $authtype
        wificonf -f $config_path set ApCliEncrypType $encrypType
        wificonf -f $config_path set ApCliWPAPSK "$WIFI_CMD_WPAPSK"



        #let Index=$Index+1
        #json_select ".."
    done

