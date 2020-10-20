    DEVICE_VENDOR=
    DEVICE_MODEL=
    DEVICE_SPEED=
    local devpath=$1
    local dir=`echo $devpath | sed 's/^\/\(.*usb[0-9]*\/[^\/]*\).*/\1/'`
    if [ -f "/sys/$dir/manufacturer" ]; then
        DEVICE_VENDOR=`cat /sys/$dir/manufacturer`
    fi
    if [ -f "/sys/$dir/product" ]; then
        DEVICE_MODEL=`cat /sys/$dir/product`
    fi
    if [ -f "/sys/$dir/speed" ]; then
        DEVICE_SPEED=`cat /sys/$dir/speed`
    fi
