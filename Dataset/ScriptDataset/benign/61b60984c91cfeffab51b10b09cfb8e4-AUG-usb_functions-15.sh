    [ -z "$1" ] && return
    [ ! -d "$USB_STORAGE_DIR" ] && return
    USB_ID=`echo "$1" | awk '{FS="/"}{print $NF}'`
    ulog usb autodetect "$PID bind_silex_from_storage: USB_ID=$USB_ID"
    ls "$USB_STORAGE_DIR" | grep "$USB_ID"
    [ "0" != "$?" ] && return
    echo -n "$USB_ID" > /sys/bus/usb/drivers/usb-storage/unbind
    echo -n "$USB_ID" > /sys/bus/usb/drivers/sxuptp_driver/bind
    ulog usb autodetect "$PID bind_silex_from_storage: DONE"
