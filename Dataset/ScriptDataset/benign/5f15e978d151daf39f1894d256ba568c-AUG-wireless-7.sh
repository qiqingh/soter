
    log_info "wifi" "wlanMacFilter_update"
    json_load "$(objReq wlanMacFilter json)"
    json_select "WlanMacFilterT"
    local Index="1"
    while json_get_type Type $Index && [ "$Type" = object ]; do
        local enable aclmode
        local mac0 mac1 mac2 mac3 mac4 mac5 mac6 mac7
        local mac8 mac9 mac10 mac11 mac12 mac13 mac14 mac15
        local mac16 mac17 mac18 mac19 mac20 mac21 mac22 mac23
        local mac24 mac25 mac26 mac27 mac28 mac29 mac30 mac31

        json_select "$Index"
        json_get_vars enable aclmode mac0 mac1 mac2 mac3 mac4 mac5 mac6 mac7 mac8 mac9 mac10 mac11 mac12 mac13 mac14 mac15 mac16 mac17 mac18 mac19 mac20 mac21 mac22 mac23 mac24 mac25 mac26 mac27 mac28 mac29 mac30 mac31

        log_info "wifi" "#$Index enable:$enable, aclmode:$aclmode"
        log_info "wifi" " mac0~7:   $mac0 $mac1 $mac2 $mac3 $mac4 $mac5 $mac6 $mac7"
        log_info "wifi" " mac8~15:  $mac8 $mac9 $mac10 $mac11 $mac12 $mac13 $mac14 $mac15"
        log_info "wifi" " mac16~23: $mac16 $mac17 $mac18 $mac19 $mac20 $mac21 $mac22 $mac23"
        log_info "wifi" " mac24~31: $mac24 $mac25 $mac26 $mac27 $mac28 $mac29 $mac30 $mac31"

        local path mac_list=""
        local dot=";"

        [ "$mac0" != "" ] && mac_list=$mac0;
        [ "$mac1" != "" ] && mac_list=$mac_list$dot$mac1;
        [ "$mac2" != "" ] && mac_list=$mac_list$dot$mac2;
        [ "$mac3" != "" ] && mac_list=$mac_list$dot$mac3;
        [ "$mac4" != "" ] && mac_list=$mac_list$dot$mac4;
        [ "$mac5" != "" ] && mac_list=$mac_list$dot$mac5;
        [ "$mac6" != "" ] && mac_list=$mac_list$dot$mac6;
        [ "$mac7" != "" ] && mac_list=$mac_list$dot$mac7;

        [ "$mac8" != "" ] && mac_list=$mac_list$dot$mac8;
        [ "$mac9" != "" ] && mac_list=$mac_list$dot$mac9;
        [ "$mac10" != "" ] && mac_list=$mac_list$dot$mac10;
        [ "$mac11" != "" ] && mac_list=$mac_list$dot$mac11;
        [ "$mac12" != "" ] && mac_list=$mac_list$dot$mac12;
        [ "$mac13" != "" ] && mac_list=$mac_list$dot$mac13;
        [ "$mac14" != "" ] && mac_list=$mac_list$dot$mac14;
        [ "$mac15" != "" ] && mac_list=$mac_list$dot$mac15;

        [ "$mac16" != "" ] && mac_list=$mac_list$dot$mac16;
        [ "$mac17" != "" ] && mac_list=$mac_list$dot$mac17;
        [ "$mac18" != "" ] && mac_list=$mac_list$dot$mac18;
        [ "$mac19" != "" ] && mac_list=$mac_list$dot$mac19;
        [ "$mac20" != "" ] && mac_list=$mac_list$dot$mac20;
        [ "$mac21" != "" ] && mac_list=$mac_list$dot$mac21;
        [ "$mac22" != "" ] && mac_list=$mac_list$dot$mac22;
        [ "$mac23" != "" ] && mac_list=$mac_list$dot$mac23;

        [ "$mac24" != "" ] && mac_list=$mac_list$dot$mac24;
        [ "$mac25" != "" ] && mac_list=$mac_list$dot$mac25;
        [ "$mac26" != "" ] && mac_list=$mac_list$dot$mac26;
        [ "$mac27" != "" ] && mac_list=$mac_list$dot$mac27;
        [ "$mac28" != "" ] && mac_list=$mac_list$dot$mac28;
        [ "$mac29" != "" ] && mac_list=$mac_list$dot$mac29;
        [ "$mac30" != "" ] && mac_list=$mac_list$dot$mac30;
        [ "$mac31" != "" ] && mac_list=$mac_list$dot$mac31;

        # rm ;
        [ "${mac_list:0:1}" == ";" ] && mac_list=${mac_list:1}


        log_info "wifi" " mac_list:$mac_list"
        wificonf -f $PATH_24G set AccessPolicy0 $aclmode
        wificonf -f $PATH_24G set AccessControlList0 "$mac_list"
        wificonf -f $PATH_24G set AccessPolicy1 $aclmode
        wificonf -f $PATH_24G set AccessControlList1 "$mac_list"

        wificonf -f $PATH_5G set AccessPolicy0 $aclmode
        wificonf -f $PATH_5G set AccessControlList0 "$mac_list"
        wificonf -f $PATH_5G set AccessPolicy1 $aclmode
        wificonf -f $PATH_5G set AccessControlList1 "$mac_list"


        let Index=$Index+1
        json_select ".."
    done

