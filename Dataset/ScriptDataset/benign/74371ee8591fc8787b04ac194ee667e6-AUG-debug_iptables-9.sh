    iptables -t filter -S input_wan_rule
    iptables -t filter -S input_wan_mgmt
    iptables -t filter -S input_lan_rule
    iptables -t filter -S input_lan_mgmt
    iptables -t nat -S prerouting_wan_rule
    iptables -t nat -S prerouting_wan_mgmt
    printf "\n"
