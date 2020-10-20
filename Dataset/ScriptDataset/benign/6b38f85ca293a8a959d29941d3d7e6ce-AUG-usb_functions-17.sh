  [ -z "$1" ] && return
  if [ -d "/sys/block/$1" ] ; then
    ulog usb autodetect "$PID /sys/block/$1 is existed"
    USB_ID=`ls -al "/sys/block/$1" | grep "device" | sed -n 's/.*\([1-9]-[1-9]:[0-9].[0-9]\).*/\1/p'`
    if [ -z "$USB_ID" ] ; then
      USB_ID=`ls -al "/sys/block/$1" | grep "device" | sed -n 's/.*\([1-9]-[1-9].[1-9]\).*/\1/p'`
    fi
    ulog usb autodetect "$PID get_usb_id_from_sysblock: USB_ID=$USB_ID"    
  fi
