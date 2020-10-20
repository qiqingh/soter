    log_info "wifi" "wlanBasic_update"


    json_load "$(objReq wlanBasic json)"
    json_select "WlanBasicT"
    local Index="1"

    while json_get_type Type $Index && [ "$Type" = object ]; do
        local enable wifimode ssid  ifname channel type bw hiddenAP ETxBfEnCond

        json_select "$Index"
        json_get_vars enable wifimode ssid  ifname channel type bw hiddenAP ETxBfEnCond

        log_info "wifi" "#$Index enable:$enable, wifimode:$wifimode, ssid:$ssid, ifname:$ifname, channel:$channel"
		log_info "wifi" " type:$type, bw:$bw, hiddenAP:$hiddenAP, ETxBfEnCond:$ETxBfEnCond"

        local config_path
        if [ $type = "2" ]; then
            config_path=$PATH_24G
			onoff_2g=$enable
        elif [ $type = "5" ]; then
            config_path=$PATH_5G
			onoff_5g=$enable
        fi
        
        #update geust network SSID1
        [ "$type" = "2" -a  "$ssid" != "" ] && BYPASS_MAIN_SSID_2G=$ssid
        [ "$type" = "5" -a  "$ssid" != "" ] && BYPASS_MAIN_SSID_5G=$ssid
        
        

		WIFI_CMD_SSID=$(echo $ssid | sed 's/[$]/\$/g')
		WIFI_CMD_SSID=$(echo $WIFI_CMD_SSID | sed 's/[`]/\`/g')
		WIFI_CMD_SSID=$(echo $WIFI_CMD_SSID | sed 's/["]/\"/g')

        wificonf -f $config_path set WirelessMode $wifimode
        wificonf -f $config_path set SSID1 "$WIFI_CMD_SSID"
        wificonf -f $config_path set Channel $channel


        if  [ "$channel" = "0" ]; then
            wificonf -f $config_path set AutoChannelSelect 2
        else
            wificonf -f $config_path set AutoChannelSelect 0
            [ $type = "2" ] && [ "$channel" -lt "5" ] && wificonf -f $config_path set HT_EXTCHA 1
            [ $type = "2" ] && [ "$channel" -gt "7" ] && wificonf -f $config_path set HT_EXTCHA 0
            
        fi

        wificonf -f $config_path set HideSSID 0 $hiddenAP


        wificonf -f $config_path set ETxBfEnCond $ETxBfEnCond

        if  [ $type = "2" ] && [ $bw = "0" ]; then
            wificonf -f $config_path set HT_BW 1
            wificonf -f $config_path set VHT_BW 0
            wificonf -f $config_path set HT_BSSCoexistence 1
            
        elif  [ $type = "2" ] && [ $bw = "2" ]; then
            wificonf -f $config_path set HT_BW 1
            wificonf -f $config_path set VHT_BW 0
            wificonf -f $config_path set HT_BSSCoexistence 0


        elif  [ $type = "5" ] && [ $bw = "0" -o $bw = "3" ]; then
            wificonf -f $config_path set HT_BW 1
            wificonf -f $config_path set VHT_BW 1

        elif [ $type = "5" ] && [ $bw = "2" ]; then
            wificonf -f $config_path set HT_BW 1
            wificonf -f $config_path set VHT_BW 0
        else

            wificonf -f $config_path set HT_BW 0
            wificonf -f $config_path set VHT_BW 0
        fi

        let Index=$Index+1
        json_select ".."

    done

