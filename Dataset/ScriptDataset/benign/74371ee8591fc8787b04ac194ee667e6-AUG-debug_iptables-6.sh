    iptables -t filter -S forwarding_wan_rule
    iptables -t filter -S forwarding_wan_port_trigger
    iptables -t nat -S prerouting_wan_rule
    iptables -t nat -S prerouting_wan_port_trigger
    iptables -t nat -S prerouting_lan_rule
    iptables -t nat -S prerouting_lan_port_trigger
    printf "\n"
