    log_info "network/guest" "setup uci"
	
#	main_lan_ip=`uci get network.lan.ipaddr`
#    main_lan_netmask=`uci get network.lan.netmask`
    main_lan_ip=$1
    main_lan_netmask=$2
    log_info "network/guest" "main_lan_ip:$main_lan_ip main_lan_netmask:$main_lan_netmask"
	
	langstIsOverlay="$(check_overlay $main_lan_ip $main_lan_netmask '192.168.33.1' '255.255.255.0')"
	
    json_load "$(objReq wlanGuest json)"
    json_select "WlanGuestT"
    local Index="1" gst_enable_2g=0 gst_enable_5g=0
    while json_get_type Type $Index && [ "$Type" = object ]; do
        local enable ssid type ifname   

        json_select "$Index"
        json_get_vars enable ssid type ifname
        log_info "network/guest" "#$Index enable:$enable, ssid:$ssid"

        [ $type = "2" -a  $enable = "1" ] && gst_enable_2g=1
        [ $type = "5" -a  $enable = "1" ] && gst_enable_5g=1

        let Index=$Index+1
        json_select ".."
    done
    
    if [ "$gst_enable_2g" = "1"  -o "$gst_enable_5g" = "1"  ]; then
        uci set network.guest='interface'
        uci set network.guest.type='bridge'
        uci set network.guest.proto='static'
        uci set network.guest.ifname='ra1 rai1'
        if [ "$langstIsOverlay" = "1" ]; then
            uci set network.guest.ipaddr='192.168.34.1'
        else
            uci set network.guest.ipaddr='192.168.33.1'
        fi
        
        uci set network.guest.netmask='255.255.255.0'
    else
        uci delete network.guest
    fi
    
    uci commit network
