    MACCLONE_ACTIVE=`sysevent get wan_mac_clone_active`
    if [ -n "$MACCLONE_ACTIVE" -a "1" = "$MACCLONE_ACTIVE" ] ; then
        ulog wan status "$PID restore wan mac addr for interface($SYSEVENT_current_wan_ifname) to factory $WAN_IFNAME_MAC"
        if [ -n "$SYSCFG_hardware_vendor_name" -a "$SYSCFG_hardware_vendor_name" = "Broadcom" ] ; then
           WAN_IFNAME_MAC=`nvram get hw_mac_addr`
           if [ -n "$WAN_IFNAME_MAC" ] ; then
               /sbin/macclone $SYSEVENT_current_wan_ifname $WAN_IFNAME_MAC
           fi
        else
            if [ "`cat /etc/product`" = "viper" -o "`cat /etc/product`" = "audi" ] ; then
                WAN_IFNAME_MAC=`fw_printenv | grep eth1addr | cut -d'=' -f2`
            else
                WAN_IFNAME_MAC=`syscfg get wan_mac_addr`
            fi
            if [ -n "$WAN_IFNAME_MAC" ] ; then
                ip link set $SYSEVENT_current_wan_ifname address $WAN_IFNAME_MAC
            fi
        fi
        sysevent set wan_mac_clone_active 0
    fi
