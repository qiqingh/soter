  [ ! -d "$USB_SILEX_DIR" ] && return 0
  [ -z "$1" ] && return 1
  BLOCK_DEVICE=`echo "$1" | cut -b 1-3`
  get_usb_id_from_sysblock $BLOCK_DEVICE
  [ -z "$USB_ID" ] && return 1
  ulog usb autodetect "$PID is_normal_usb_storage: USB_ID=$USB_ID"
  ls -al "$USB_SILEX_DIR" | grep -q "$USB_ID"
  [ "0" = "$?" ] && return 1
  return 0
