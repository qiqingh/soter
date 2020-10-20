    log_info "wps" "record_security_setting $1"
    sleep 4

    local config_path ssid authtype encrypType wpaPsk index
    if [ $1 = "ra0" ]; then
        config_path=$PATH_24G
        index=0
    elif [ $1 = "rai0" ]; then
        config_path=$PATH_5G
        index=1
    fi

    ssid=`wificonf -f $config_path get SSID1`
    authtype=`wificonf -f $config_path get AuthMode 0`
    encrypType=`wificonf -f $config_path get EncrypType 0`
    wpaPsk=`wificonf -f $config_path get WPAPSK1 0`
    wscStatus=`wificonf -f $config_path get WscConfStatus 0`
    log_info "wps" "ifname:$1"
    log_info "wps" "ssid:$ssid authtype:$authtype encrypType:$encrypType wpaPsk:$wpaPsk wscStatus:$wscStatus"


    objReq wlanBasic setparam $index ssid "$ssid"
    objReq wlanSecurity setparam $index authtype "$authtype"
    objReq wlanSecurity setparam $index encrypType "$encrypType"
    objReq wlanSecurity setparam $index wpaPsk "$wpaPsk"

    objReq wlanWps setparam 0 wscConfStatus "$wscStatus"

    gnvram commit
