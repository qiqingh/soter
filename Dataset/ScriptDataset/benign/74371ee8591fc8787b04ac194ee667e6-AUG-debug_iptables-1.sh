    iptables -t mangle -S PREROUTING
    iptables -t mangle -S wanattack
    iptables -t filter -S input_wan_rule
    iptables -t filter -S input_wan_firewall
    iptables -t filter -S forwarding_lan_rule
    iptables -t filter -S forwarding_lan_firewall
    iptables -t filter -S forwarding_wan_rule
    iptables -t filter -S forwarding_wan_firewall
    printf "\n"
