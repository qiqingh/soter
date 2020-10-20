        #adding the rule to MINIUPNPD
        iptables -wt nat -N MINIUPNPD
        iptables -wt nat -A PREROUTING -i $WANIF -j MINIUPNPD
        iptables -wt filter -N MINIUPNPD
        iptables -wt filter -A FORWARD -i $WANIF ! -o $WANIF -j MINIUPNPD
