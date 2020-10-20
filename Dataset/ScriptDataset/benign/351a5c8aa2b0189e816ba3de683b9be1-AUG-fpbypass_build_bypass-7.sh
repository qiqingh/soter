    if [ -f /proc/net/fpbypass_ipv4_set_wan ]; then
        wan_ip=`sysevent get ipv4_wan_ipaddr`
        echo "$wan_ip" > /proc/net/fpbypass_ipv4_set_wan
    fi
