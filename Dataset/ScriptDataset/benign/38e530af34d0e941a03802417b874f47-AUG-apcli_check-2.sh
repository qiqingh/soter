    json_load "$(objReq wlanBridge json)"
    json_select "WlanBridgeT"
    local Index="1"

    
    while json_get_type Type $Index && [ "$Type" = object ]; do
        local  ssid ifname type authtype encrypType wpaPsk

        json_select "$Index"
        json_get_vars ssid ifname type authtype encrypType wpaPsk
        
        #echo "ssid:$ssid ifname:$ifname type:$type " > /dev/console
        #echo "authtype:$authtype encrypType:$encrypType wpaPsk:$wpaPsk" > /dev/console

        
        
        WIFI_CMD_SSID=$(echo $ssid | sed 's/[$]/\$/g')
		WIFI_CMD_SSID=$(echo $WIFI_CMD_SSID | sed 's/[`]/\`/g')
		WIFI_CMD_SSID=$(echo $WIFI_CMD_SSID | sed 's/["]/\"/g')
		WIFI_CMD_WPAPSK=$(echo $wpaPsk | sed 's/[$]/\$/g')
		WIFI_CMD_WPAPSK=$(echo $WIFI_CMD_WPAPSK | sed 's/[`]/\`/g')
		WIFI_CMD_WPAPSK=$(echo $WIFI_CMD_WPAPSK | sed 's/["]/\"/g')
        
        
        WIFI_CMD_AUTHTYPE=$authtype
        WIFI_CMD_ENCRYPTYPE=$encrypType
        
        if [ $type = "2" ]; then
            config_path=$PATH_24G
            ifname_cmd="apcli0"
            main_ifname="ra0"
            
        elif [ $type = "5" ]; then
            config_path=$PATH_5G
            ifname_cmd="apclii0"
            main_ifname="rai0"
        fi

        #let Index=$Index+1
        #json_select ".."
    done
    

