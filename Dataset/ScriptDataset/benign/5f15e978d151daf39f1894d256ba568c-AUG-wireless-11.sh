    log_info "wifi" "update_wireless_config"
    wlanMacaddr_update
    wlanMpt_update
    wlanBasic_update
    wlanSecurity_update
    wlanGuset_update
    wlanMacFilter_update
    wlanBridge_update
    wlanWps_update

    # MFG check
    wireless_MFG_check


    log_info "wifi" "update_wireless_config end"
    rcConf restart upnpd
