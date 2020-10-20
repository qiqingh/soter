    json_load "$(objReq wan json)"
    json_select "WanP"
    json_get_var wanmode proto
    json_get_var wanif ifname

    if [ "$wanmode" != "$WAN_PROTO_BRIDGE" -a "$wanmode" != "$WAN_PROTO_WLAN_BRIDGE" ]; then
        master_lan_obj2uci
        master_lan_dhcp_obj2uci
        
        main_lan_ip=`uci get network.lan.ipaddr`
        main_lan_netmask=`uci get network.lan.netmask`
        guest_lan_obj2uci $main_lan_ip $main_lan_netmask
        guest_lan_dhcp_obj2uci
    else
        echo "Ignore DHCP require in bridge mode" > /dev/console
        uci set dhcp.lan.ignore="1"
        echo "" > /tmp/dhcp.leases
        uci commit dhcp
        
        main_lan_ip=`ifconfig br-lan | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'`
        main_lan_netmask=`ifconfig br-lan | grep 'Mask' | cut -d: -f4`

        if [ "$main_lan_ip" != "" -a "$main_lan_netmask" != "" ] ; then
            guest_lan_obj2uci $main_lan_ip $main_lan_netmask
        else
            main_lan_ip=`uci get network.lan.ipaddr`
            main_lan_netmask=`uci get network.lan.netmask`
            guest_lan_obj2uci $main_lan_ip $main_lan_netmask
        fi    
        guest_lan_dhcp_obj2uci
    fi
