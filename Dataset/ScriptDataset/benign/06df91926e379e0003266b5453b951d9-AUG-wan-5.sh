    log_info "network/wan" "setup l2tp"

    local option_var=""
    json_load "$(objReq l2tp json)"
    json_select "L2tpP"
    json_get_vars enable username password vpnServer mode idleTime redialPeriod mtuMode mtu
    json_select ".."

    uci del network.vpn
    uci set network.vpn='interface'
    uci set network.vpn.proto='l2tp'
    uci set network.vpn.server="$vpnServer"
    uci set network.vpn.username="$username"
    uci set network.vpn.password="$password"
    uci set network.vpn.defaultroute='1'
    uci set network.vpn.auto='1'
    uci set network.vpn.checkup_interval='30'
    option_var="nomppe dump usepeerdns"

    # ondemand = 0, keepalive, redialPeriod: 1~59 seconds
    # ondemand = 1, connect on demand, maxIdleTime: 5~999 mins
    #
    # keepalive='v1 v2', v1:lcp-echo-interval v2:lcp-echo-failure
    #
    var="3"
    if [ "$mode" = "0" ]; then
        #uci set network.vpn.keepalive="${redialPeriod} ${var}"
        uci set network.vpn.keepalive="${var} ${redialPeriod}"
    else
        #uci set network.vpn.demand="$idleTime"
        local t=$( expr 60 '*' "$idleTime")
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

    conf="/etc/xl2tpd/xl2tpd.conf"
    conf_ppp="/etc/ppp/options.xl2tpd"
    sed -i "s/lns = .*/lns = ${vpnServer}/g" $conf
    sed -i "/user */d" $conf_ppp
    sed -i "/password */d" $conf_ppp
    echo "user ${username}" >> $conf_ppp
    echo "password ${password}" >> $conf_ppp
