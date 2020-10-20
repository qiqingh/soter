    iptables -t filter -S forwarding_wan_rule
    iptables -t filter -S forwarding_wan_dmz
    iptables -t nat -S prerouting_wan_rule
    iptables -t nat -S prerouting_wan_dmz
    printf "\n"
