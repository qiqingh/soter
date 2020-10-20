    DEVICE_TYPE="usb"
    DEVICE_PORT=
    local devpath="$1"
    get_count_usb_host
    if [ "$USB_HOST_CNT" -gt "1" ] ; then
        get_usb_port_from_multiple_host "$devpath"
    else
        get_usb_port_from_single_host "$devpath"
    fi
    DEVICE_PORT=$USB_port
    ulog usb autodetect "$PID Hotplug_GetIdFromDevpath: $DEVICE_TYPE $DEVICE_PORT"
