    log_info "network/wan" "setup bridge mode"

    json_load "$(objReq bridge json)"
    json_select BridgeP
    json_get_vars mode ip netmask gateway routername
    json_select ".."
    json_load "$(objReq lan json)"
    json_select LanP
    json_get_var lanif ifnameList
    json_select ".."

    if [ "$mode" = "1" ]; then
        log_info "network/wan" "bridge mode:$mode, routername:$routername ip=$ip, netmask=$netmask, gateway=$gateway"
    else
        log_info "network/wan" "bridge mode:$mode, routername:$routername"
    fi

    uci set network.wan.disabled='1'
    uci set network.wan6.disabled='1'
    uci set network.lan.ifname="$lanif $wanif"

    if [ "$mode" = "0" ]; then
        uci set network.lan.proto='dhcp'
    elif [ "$mode" = "1" ]; then
        uci set network.lan.proto='static'
        uci set network.lan.ipaddr="$ip"
        uci set network.lan.netmask="$netmask"
        uci set network.lan.gateway="$gateway"
    else
        log_info "network/wan" "unknown bridge mode!"
    fi
    #Clean dhcp lease file
    echo "" > /tmp/dhcp.leases
