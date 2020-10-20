    if [ "$1" = "$WAN_PROTO_BRIDGE" -o "$1" = "$WAN_PROTO_WLAN_BRIDGE" ]; then
        uci del network.lan6
        uci set network.lan6='interface'
        uci set network.lan6.ifname='br-lan'
        uci set network.lan6.proto='dhcpv6'
        uci set dhcp.lan.dhcpv6='disabled'
        uci set dhcp.lan.ra='disabled'
    else
        uci del network.lan6
        uci set dhcp.lan.ra='server'
        uci set dhcp.lan.dhcpv6='server'
    fi

    uci_changes=$(uci changes network)
    if [ -n "$uci_changes" ]; then
        uci commit dhcp
        uci commit network
    fi
