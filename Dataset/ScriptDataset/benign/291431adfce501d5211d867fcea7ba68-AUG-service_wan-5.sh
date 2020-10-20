    if [ "$SYSCFG_def_hwaddr" != "" ] && [ "$SYSCFG_def_hwaddr" != "00:00:00:00:00:00" ]; then
        ulog wan status "$PID change wan mac addr for interface($SYSEVENT_current_wan_ifname) to $SYSCFG_def_hwaddr"
        if [ -n "$SYSCFG_hardware_vendor_name" -a "$SYSCFG_hardware_vendor_name" = "Broadcom" ] ; then
            /sbin/macclone $SYSEVENT_current_wan_ifname $SYSCFG_def_hwaddr
        else
            ip link set $SYSEVENT_current_wan_ifname down
            ip link set $SYSEVENT_current_wan_ifname address $SYSCFG_def_hwaddr
            ip link set $SYSEVENT_current_wan_ifname up
        fi
        sysevent set wan_mac_clone_active 1
    fi
