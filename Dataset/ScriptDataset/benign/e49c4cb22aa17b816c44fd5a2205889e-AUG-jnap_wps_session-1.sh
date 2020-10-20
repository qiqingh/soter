    iface=$(syscfg get lan_wl_physical_ifnames | awk -F" " '{print $1}')
    pin=$(sysevent get ${SERVICE_NAME}-pin)
    if [ -n "$pin" ] && [ "NULL" != "$pin" ]; then
        ulog ${SERVICE_NAME} status "starting WPS session with PIN $pin"
        /sbin/wlancfg ${iface} wps-pin-start $pin > /dev/null 2>&1
    else
        ulog ${SERVICE_NAME} status "starting WPS PBC session"
        /sbin/wlancfg ${iface} wps-pbc-start > /dev/null 2>&1
    fi
