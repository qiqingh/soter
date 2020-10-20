    iface=$(syscfg get lan_wl_physical_ifnames | awk -F" " '{print $1}')
    ulog ${SERVICE_NAME} status "stopping WPS session"
    /sbin/wlancfg $iface wps-stop
