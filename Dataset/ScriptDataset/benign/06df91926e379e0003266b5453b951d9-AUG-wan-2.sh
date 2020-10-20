    log_info "network/wan" "setup dhcpc"

    local mac_addr
    json_load "$(objReq dhcpc json)"
    json_select "DhcpcP"
    json_get_vars hostName domainName mtuMode mtu
    json_select ".."
    json_load "$(objReq wan json)"
    json_select "WanP"
    json_get_vars ifname
    json_select ".."

    mac_addr=$(uci get network.wan.macaddr)
    uci del network.wan
    uci set network.wan=interface
    uci set network.wan.proto='dhcp'
    if [ -z "$VLAN_IFNAME" ]; then
        uci set network.wan.ifname="$ifname"
    else
        uci set network.wan.ifname="${ifname}${VLAN_IFNAME}"
    fi
    uci set network.wan.macaddr="$mac_addr"
    uci set network.wan.peerdns='1'
    uci set network.wan.force_link='1'

    # mtuMode "0: auto, 1: manual"
    if [ "$mtuMode" = "0" ]; then
        uci set network.wan.mtu='1500'
    else
        uci set network.wan.mtu="$mtu"
    fi
