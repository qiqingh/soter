    local usbport=$1
    local usbtype=$2
        if [ "$usbtype" = "esata" -a "$usbport" = "1" ]; then
            UMOUNT="esata"
            return
        fi
        if [ "$usbtype" = "usb" -a "$usbport" = "1" ]; then
            UMOUNT="usb1"
            return
        fi
        if [ "$usbtype" = "usb" -a "$usbport" = "2" ]; then
            UMOUNT="usb2"
            return
        fi
