    [ -z "$1" ] && return
    get_count_usb_host
    
    if [ "$USB_HOST_CNT" = "3" -o "$USB_HOST_CNT" = "2" ] ; then
      get_usb_port_from_multiple_host $1
    else
      USB_PORT=`echo "$1" | awk '{FS="/"}{print $NF}' | cut -d ':' -f 1`
      ulog usb autodetect "$PID get_removed_usb_device_port: USB_PORT=$USB_PORT"
      [ -z "$USB_PORT" ] && return
      CUR_USB_PORT=`echo $USB_PORT | cut -d '.' -f 2`
      [ "$USB_PORT" = "$CUR_USB_PORT" ] && USB_port="1" && return
      USB_port=`expr $CUR_USB_PORT - 2`
    fi
    
    ulog usb autodetect "$PID get_removed_usb_device_port: USB_port=$USB_port"
