    if [ -z "$USB_HOST_CNT" ]; then
        USB_HOST_CNT=`ls "$USB_DEVICES_DIR" | grep -c "usb[1-9]"`
    fi
