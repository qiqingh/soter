    log_info "wifi" "wireless_services_stop"
    WAN_IF=`uci -q get network.wan.ifname`
    iptables -D FORWARD -i $WAN_IF -o br-guest -m state --state RELATED,ESTABLISHED -j ACCEPT

    log_info "wifi" "wireless_services_stop end"
