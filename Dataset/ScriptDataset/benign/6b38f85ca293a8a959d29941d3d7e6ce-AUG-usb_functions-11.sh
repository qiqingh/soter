    USB_HOST_CNT=`ls "$USB_DEVICES_DIR" | grep -c "usb[1-9]"`
    ulog usb autodetect "$PID USB_HOST_CNT=$USB_HOST_CNT"
