    if [ ! -d "$USB_SILEX_DIR" ]; then
        return 0
    fi
    local devname=$1
    if [ -z "$devname" ]; then
        return 1
    fi
 
    Hotplug_GetDevpath "$devname"
    local usb_id=`echo $DEVICE_PATH | sed -n 's/.*\([1-9]-[1-9]:[0-9].[0-9]\).*/\1/p'`
    if [ -z "$usb_id" ]; then
        usb_id=`echo $DEVICE_PATH | sed -n 's/.*\([1-9]-[1-9].[1-9]\).*/\1/p'`
    fi
    ulog usb autodetect "$PID Hotplug_IsDeviceStorage - id: $usb_id"
    if [ -z "$usb_id" ]; then
        return 0
    fi
    ls -al "$USB_SILEX_DIR" | grep -q "$usb_id"
    if [ "$?" == "0" ]; then
        return 1
    fi
    return 0
