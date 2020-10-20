  [ -z "$1" ] && return
  BLOCK_DEVICE=`echo "$1" | cut -b 1-3`
  get_usb_id_from_sysblock $BLOCK_DEVICE
  get_count_usb_host
  if [ "$USB_HOST_CNT" = "3" -o "$USB_HOST_CNT" = "2" ] ; then
    get_usb_port_from_multiple_host $USB_ID
  elif [ "$USB_HOST_CNT" = "1" ] ; then
    get_usb_port_from_single_host $USB_ID
  fi
  ulog usb autodetect "$PID get_usb_port_from_storage_drive: USB_ID=$USB_ID"
  ulog usb autodetect "$PID get_usb_port_from_storage_drive: USB_port=$USB_port"
