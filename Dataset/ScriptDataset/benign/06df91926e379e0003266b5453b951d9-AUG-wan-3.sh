    log_info "network/wan" "setup pppoe"

    local mac_addr
    local option_var=""
    json_load "$(objReq pppoe json)"
    json_select "PppoeP"
    json_get_vars enable username password autoType ondemand maxIdleTime mtuMode mtu serviceName redialPeriod
    json_select ".."
    json_load "$(objReq wan json)"
    json_select "WanP"
    json_get_vars ifname
    json_select ".."
    json_load "$(objReq ipv6 json)"
    json_select "Ipv6P"
    json_get_vars dhcp6cEnable tun6rdMode
    json_select ".."

    mac_addr=$(uci get network.wan.macaddr)
    uci del network.wan
    uci set network.wan=interface
    uci set network.wan.macaddr="$mac_addr"
    uci set network.wan.username="$username"
    uci set network.wan.password="$password"
    uci set network.wan.defaultroute="1"
    if [ "$dhcp6cEnable" = "0" -a "$tun6rdMode" = "0" ]; then
        uci set network.wan.ipv6="0"
    else
        uci set network.wan.ipv6="auto"
    fi
    option_var="nomppe dump usepeerdns"

    # ondemand = 0, keepalive, redialPeriod: 20~180 seconds
    # ondemand = 1, connect on demand, maxIdleTime: 1~9999 mins
    #
    # keepalive='v1 v2', v1:lcp-echo-interval v2:lcp-echo-failure, set v2=5
    #
    var="3"
    if [ $ondemand = "0" ]; then
        #uci set network.wan.keepalive="${redialPeriod} ${var}"
        uci set network.wan.keepalive="${var} ${redialPeriod}"
        uci set network.wan.keepalive_adaptive='0'
    else
        local t=$( expr 60 '*' "$maxIdleTime")
        option_var="${option_var} idle ${t} persist demand replacedefaultroute"
        uci set network.wan.keepalive="${var} 30"
    fi

    uci set network.wan.proto='pppoe'
    if [ -z "$VLAN_IFNAME" ]; then
        uci set network.wan.ifname="$ifname"
    else
        uci set network.wan.ifname="${ifname}${VLAN_IFNAME}"
    fi
    uci set network.wan.peerdns='1'
    uci set network.wan.force_link='1'
    uci set network.wan.service="$serviceName"
    # mtuMode "0: auto, 1: manual"
    if [ "$mtuMode" = "0" ]; then
        uci set network.wan.mtu='1492'
    else
        uci set network.wan.mtu="$mtu"
    fi

    [ -f /tmp/.firstWizard ] && uci set network.wan.authfail='1' || uci set network.wan.authfail='0'

    uci set network.wan.pppd_options="$option_var"
