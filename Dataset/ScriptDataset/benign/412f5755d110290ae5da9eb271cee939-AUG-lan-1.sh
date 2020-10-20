    log_info "network/lan" "setup uci"

    json_load "$(objReq lan json)"
    json_select "LanP"
    json_get_vars name ifnameList ipaddr netmask

    log_info "network/lan" "name:$name, ifname:$ifnameList, address:$ipaddr, netmask:$netmask"

    uci set network.lan.ifname=$ifnameList
    uci set network.lan.ipaddr=$ipaddr
    uci set network.lan.netmask=$netmask
    uci set network.lan.proto='static'
    uci set network.lan.gateway=''
    uci set network.wan.disabled=''
    uci set network.wan6.disabled=''

    uci commit network

    checkurl=`cat /etc/hosts | grep "$ipaddr"`
    [ -z $checkurl ] && {
        log_info "network/lan" "setup url"
        sed -i '/myrouter/d' /etc/hosts
        echo "$ipaddr myrouter.local" >> /etc/hosts
    }
