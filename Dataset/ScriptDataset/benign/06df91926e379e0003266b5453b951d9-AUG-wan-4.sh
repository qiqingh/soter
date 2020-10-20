    log_info "network/wan" "setup pptp"

    local option_var=""
    local mac_addr
    json_load "$(objReq pptp json)"
    json_select "PptpP"
    json_get_vars enable username password autoObtain vpnServer ipaddr netmask gateway dns1 dns2 dns3 mtuMode mtu ondemand maxIdleTime redialPeriod
    json_select ".."
    json_load "$(objReq wan json)"
    json_select "WanP"
    json_get_vars ifname
    json_select ".."

    uci del network.vpn
    uci set network.vpn='interface'
    uci set network.vpn.proto='pptp'
    uci set network.vpn.server="$vpnServer"
    uci set network.vpn.username="$username"
    uci set network.vpn.password="$password"
    uci set network.vpn.defaultroute='1'
    uci set network.vpn.ipv6='0'
    option_var="nomppe dump usepeerdns"

    # autoObtain
    # 0: specify an ipv4 address, set static ip for wan
    # 1: Obtain ipv4 address automatically
    #
    if [ "$autoObtain" = "0" ]; then
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
        uci set network.wan.ipaddr="$ipaddr"
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

        option_var="nomppe dump"
    fi

    # ondemand = 0, keepalive, redialPeriod: 1~59 seconds
    # ondemand = 1, connect on demand, maxIdleTime: 5~999 mins
    #
    # keepalive='v1 v2', v1:lcp-echo-interval v2:lcp-echo-failure
    #
    var="3"
    if [ "$ondemand" = "0" ]; then
        #uci set network.vpn.keepalive="${redialPeriod} ${var}"
        uci set network.vpn.keepalive="${var} ${redialPeriod}"
        uci set network.vpn.keepalive_adaptive='0'
    else
        #uci set network.vpn.demand="$maxIdleTime"
        local t=$( expr 60 '*' "$maxIdleTime")
        option_var="${option_var} idle ${t} persist demand replacedefaultroute"
        uci set network.vpn.keepalive="${var} 30"
    fi

    # mtuMode "0: auto, 1: manual"
    if [ "$mtuMode" = "0" ]; then
        uci set network.wan.mtu='1460'
    else
        uci set network.wan.mtu="$mtu"
    fi
    uci set network.vpn.pppd_options="$option_var"
