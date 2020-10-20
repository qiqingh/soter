    log_info "wifi" "wlanSecurity_update"

    json_load "$(objReq wlanSecurity json)"
    json_select "WlanSecurityT"
    local Index="1"
    while json_get_type Type $Index && [ "$Type" = object ]; do
        local  type ifname authtype encrypType wpaPsk rs_ip rs_port rs_password

        json_select "$Index"
        json_get_vars type ifname authtype encrypType wpaPsk rs_ip rs_port rs_password
        log_info "wifi" "#$Index ifname:$ifname, type:$type, authtype:$authtype, encrypType:$encrypType, wpaPsk:$wpaPsk"
		log_info "wifi" " rs_ip:$rs_ip, rs_port:$rs_port, rs_password:$rs_password"

        local config_path

        [ $type = "2" ] && config_path=$PATH_24G
        [ $type = "5" ] && config_path=$PATH_5G


		WIFI_CMD_WPAPSK=$(echo $wpaPsk | sed 's/[$]/\$/g')
		WIFI_CMD_WPAPSK=$(echo $WIFI_CMD_WPAPSK | sed 's/[`]/\`/g')
		WIFI_CMD_WPAPSK=$(echo $WIFI_CMD_WPAPSK | sed 's/["]/\"/g')


        wificonf -f $config_path set AuthMode 0 $authtype
        wificonf -f $config_path set EncrypType 0 $encrypType
        wificonf -f $config_path set WPAPSK1 "$WIFI_CMD_WPAPSK"
		wificonf -f $config_path set RADIUS_Server "$rs_ip"
		wificonf -f $config_path set RADIUS_Port $rs_port
		wificonf -f $config_path set RADIUS_Key1 "$rs_password"

        let Index=$Index+1
        json_select ".."
    done

