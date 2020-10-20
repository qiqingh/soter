    log_info "network/wan" "setup staticip"

    local mac_addr
    json_load "$(objReq staticip json)"
    json_select "StaticipP"
    json_get_vars ip netmask gateway dns1 dns2 dns3 mtuMode mtu
    json_select ".."
    json_load "$(objReq wan json)"
    json_select "WanP"
    json_get_vars ifname
    json_select ".."

    mac_addr=$(uci get network.wan.macaddr)
    uci del network.wan
    uci set network.wan=interface
    uci set network.wan.proto='static'
    if [ -z "$VLAN_IFNAME" ]; then
        uci set network.wan.ifname="$ifname"
    else
        uci set network.wan.ifname="${ifname}${VLAN_IFNAME}"
    fi

    uci set network.wan.macaddr="$mac_addr"
    uci set network.wan.ipaddr="$ip"
    uci set network.wan.netmask="$netmask"
    uci set network.wan.gateway="$gateway"
    uci set network.wan.force_link='1'
    uci del network.wan.dns
    if [ -n "$dns1" ]; then
        uci add_list network.wan.dns="$dns1"
    fi
    if [ -n "$dns2" ]; then
        uci add_list network.wan.dns="$dns2"
    fi
    if [ -n "$dns3" ]; then
        uci add_list network.wan.dns="$dns3"
    fi

    # mtuMode "0: auto, 1: manual"
    if [ "$mtuMode" = "0" ]; then
        uci set network.wan.mtu='1500'
    else
        uci set network.wan.mtu="$mtu"
    fi
