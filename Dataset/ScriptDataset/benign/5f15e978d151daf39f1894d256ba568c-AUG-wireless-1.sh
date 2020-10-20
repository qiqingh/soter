    log_info "wifi" "wlanMacaddr_update"
	local lan_mac=$(cat /tmp/devinfo/hw_mac_addr)
	[ -z $lan_mac ] && {
		lan_mac=$(cat /sys/class/net/eth0/address)
	}

	wlan_mac_2g=$(macaddr_add "$lan_mac" 2)
	wlan_mac_5g=$(macaddr_add "$lan_mac" 3)


    wificonf -f $PATH_24G set MacAddress $wlan_mac_2g
    wificonf -f $PATH_5G  set MacAddress $wlan_mac_5g
	log_info "wifi" "wlan_mac_2g:$wlan_mac_2g, wlan_mac_5g:$wlan_mac_5g"


