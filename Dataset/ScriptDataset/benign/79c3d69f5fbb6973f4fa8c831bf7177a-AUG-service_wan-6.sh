   MACCLONE_ACTIVE=`sysevent get wan_mac_clone_active`
   if [ -n "$MACCLONE_ACTIVE" -a "1" = "$MACCLONE_ACTIVE" ] ; then
           ulog wan status "$PID restore wan mac addr for interface($SYSEVENT_current_wan_ifname) to factory $WAN_IFNAME_MAC"
       if [ ! -z "$SYSCFG_hardware_vendor_name" -a "Marvell" = $SYSCFG_hardware_vendor_name ] ; then
           WAN_IFNAME_MAC=`fw_printenv | grep eth1addr | cut -d'=' -f2`
           ip link set $SYSEVENT_current_wan_ifname address $WAN_IFNAME_MAC
        elif [ "$SYSCFG_hardware_vendor_name" = "MediaTek" ] ; then
            WAN_IFNAME_MAC=`syscfg get wan_mac_addr`
            if [ -n "$WAN_IFNAME_MAC" ] ; then
                ip link set $SYSEVENT_current_wan_ifname address $WAN_IFNAME_MAC
            fi
       elif [ "$SYSCFG_hardware_vendor_name" = "Broadcom" ] ; then
           WAN_IFNAME_MAC=`nvram get hw_mac_addr`
           if [ -n "$WAN_IFNAME_MAC" ] ; then
               /sbin/macclone $SYSEVENT_current_wan_ifname $WAN_IFNAME_MAC
           fi
        elif [ "$SYSCFG_hardware_vendor_name" = "QCA" ] ; then
            WAN_IFNAME_MAC=`syscfg get wan_mac_addr`
            if [ -n "$WAN_IFNAME_MAC" ] ; then
                ip link set $SYSEVENT_current_wan_ifname down
                ip link set $SYSEVENT_current_wan_ifname address $WAN_IFNAME_MAC
                ip link set $SYSEVENT_current_wan_ifname up
            fi
       fi
       sysevent set wan_mac_clone_active 0
   fi
