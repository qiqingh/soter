    iptables -t filter -S forwarding_wan_rule
    iptables -t filter -S forwarding_wan_sp_forward
    iptables -t nat -S prerouting_wan_rule
    iptables -t nat -S prerouting_wan_sp_forward
    iptables -t nat -S prerouting_lan_rule
    iptables -t nat -S prerouting_lan_sp_forward
    iptables -t nat -S postrouting_lan_rule
    iptables -t nat -S postrouting_lan_sp_forward
    printf "\n"
