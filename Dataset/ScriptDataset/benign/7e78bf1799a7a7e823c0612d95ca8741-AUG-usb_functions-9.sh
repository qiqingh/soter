    if [ "$2" = "on" ] ; then
    	sysevent set usb_led_status on
    	sysevent set usb_led_index ${1}
    	sysevent set usbled_on
    else
    	sysevent set usb_led_status off
    	sysevent set usb_led_index ${1}
    fi
