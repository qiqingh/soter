    if [ -f /proc/net/fpbypass_ipv4_set_lan ]; then
        lan_ipaddr=`syscfg get lan_ipaddr`
        lan_netmask=`syscfg get lan_netmask`
        echo "$lan_ipaddr $lan_netmask" > /proc/net/fpbypass_ipv4_set_lan
    fi
