
    log_info "wifi" "wlanWps_update"

    json_load "$(objReq wlanWps json)"
    json_select "WlanWpsT"
    local Index="1"
    while json_get_type Type $Index && [ "$Type" = object ]; do
        local  enable wscConfMode wscConfStatus routerPIN WscModelNumber WscSerialNumber

        json_select "$Index"
        json_get_vars enable wscConfMode wscConfStatus routerPIN WscModelNumber WscSerialNumber
        log_info "wifi" "#$Index enable:$enable, wscConfMode:$wscConfMode, wscConfStatus:$wscConfStatus"
        log_info "wifi" " PIN:$routerPIN, Model:$WscModelNumber, SN:$WscSerialNumber"


		if [ $enable = "1" ] ; then
			wificonf -f $PATH_24G set WscConfMode 7
			wificonf -f $PATH_24G set WscConfStatus $wscConfStatus
			wificonf -f $PATH_5G set WscConfMode 7
			wificonf -f $PATH_5G set WscConfStatus $wscConfStatus
        else
			wificonf -f $PATH_24G set WscConfMode 0
			wificonf -f $PATH_24G set WscConfStatus $wscConfStatus
			wificonf -f $PATH_5G set WscConfMode 0
			wificonf -f $PATH_5G set WscConfStatus $wscConfStatus
		fi


        if [ "$routerPIN" != "" ]; then
            wificonf -f $PATH_24G set WscVendorPinCode $routerPIN
            wificonf -f $PATH_5G set WscVendorPinCode $routerPIN
        fi

        if [ "$WscModelNumber" != "" ]; then
            wificonf -f $PATH_24G set WscModelNumber $WscModelNumber
            wificonf -f $PATH_5G  set WscModelNumber $WscModelNumber
        fi

        if [ "$WscSerialNumber" != "" ]; then
            wificonf -f $PATH_24G set WscSerialNumber $WscSerialNumber
            wificonf -f $PATH_5G  set WscSerialNumber $WscSerialNumber
        fi

        #let Index=$Index+1
        #json_select ".."
    done

