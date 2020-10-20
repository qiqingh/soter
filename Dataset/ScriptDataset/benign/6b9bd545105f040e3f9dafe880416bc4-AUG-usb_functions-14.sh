    [ -z "$1" ] && return
    [ ! -d "$USB_SILEX_DIR" ] && return
    USB_ID=`echo "$1" | awk '{FS="/"}{print $NF}'`
    ulog usb autodetect "$PID bind_storage_from_silex: USB_ID=$USB_ID"
    ls "$USB_SILEX_DIR" | grep "$USB_ID"
    [ "0" != "$?" ] && return
    echo -n "$USB_ID" > /sys/bus/usb/drivers/sxuptp_driver/unbind
    echo -n "$USB_ID" > /sys/bus/usb/drivers/usb-storage/bind
    ulog usb autodetect "$PID bind_storage_from_silex: DONE"
