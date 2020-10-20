    iptables -t filter -S forwarding_wan_rule
    iptables -t filter -S forwarding_wan_pr_forward
    iptables -t nat -S prerouting_wan_rule
    iptables -t nat -S prerouting_wan_pr_forward
    iptables -t nat -S prerouting_lan_rule
    iptables -t nat -S prerouting_lan_pr_forward
    iptables -t nat -S postrouting_lan_rule
    iptables -t nat -S postrouting_lan_pr_forward
    printf "\n"
