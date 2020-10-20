    pmax=`syscfg get parental_control_policy_count`
    for pidx in `seq 1 "$pmax"`; do
        policy=`syscfg get parental_control_policy_$pidx`
        dmax=`syscfg get $policy::blocked_device_count`
        for didx in `seq 1 "$dmax"`; do
            mac=`syscfg get $policy::blocked_device_$didx`
            addr_get_ipv4_from_mac $mac
            if [ ! -z "$ADDR_IPV4" ]; then
                echo $ADDR_IPV4 > /proc/net/fpbypass_ipv4_add
            fi
        done
    done
