    if [ -f /proc/net/fpbypass_ipv4_set_wan ]; then
        echo "0.0.0.0" > /proc/net/fpbypass_ipv4_set_wan
    fi
