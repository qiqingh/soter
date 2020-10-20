    log_info "network/wan" "setup network uci config"

    json_load "$(objReq wan json)"
    json_select "WanP"
    json_get_vars hostname ifname proto domainName
    json_select ".."

    check_vlan_config
    check_ipv6_bridge "$proto"

    if [ "$proto" = "$WAN_PROTO_STATIC" ]; then
        staticip_obj2uci
    elif [ "$proto" = "$WAN_PROTO_DHCPC" ]; then
        dhcpc_obj2uci
    elif [ "$proto" = "$WAN_PROTO_PPPOE" ]; then
        pppoe_obj2uci
    elif [ "$proto" = "$WAN_PROTO_PPTP" ]; then
        dhcpc_obj2uci
        pptp_obj2uci
    elif [ "$proto" = "$WAN_PROTO_L2TP" ]; then
        dhcpc_obj2uci
        l2tp_obj2uci
    elif [ "$proto" = "$WAN_PROTO_BRIDGE" ]; then
        eth_bridge_obj2uci
    elif [ "$proto" = "$WAN_PROTO_WLAN_BRIDGE" ]; then
        wlan_apcli_obj2dat
        eth_bridge_obj2uci
    else
        log_info "network" "unknown wan mode"
    fi

    uci_changes=$(uci changes network)
    if [ -n "$uci_changes" ]; then
        uci commit network
    fi

    if [ -n "$hostname" ]; then
        uci set system.@system[0].hostname="$hostname"
        uci commit system
    fi
    if [ -n "$domainName" ]; then
        uci set dhcp.@dnsmasq[0].domain="$domainName"
	uci commit dhcp
    fi
