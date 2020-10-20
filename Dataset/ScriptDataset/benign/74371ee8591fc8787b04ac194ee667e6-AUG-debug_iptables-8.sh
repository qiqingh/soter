    iptables -t filter -S forwarding_rule
    iptables -t filter -S parental_control
    for i in 1 2 3 4 5; do
        iptables -t filter -S pc_${i}
    done
