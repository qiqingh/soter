  mount | grep -q "sd[a-z]"
  if [ "0" = "$?" ] ; then
    return
  fi
  DEVS=`ls /dev/ | grep "sd[a-z][0-9]"`
  
  for d in $DEVS 
  do
    if is_normal_usb_storage $d ; then
      get_usb_port_from_storage_drive $d
      ulog usb autodetect "$PID check_mounted_usb_drives: $d on $USB_port"
      `$STORAGE_DEVICE_SCRIPT add $d $USB_port`
      sleep 1
    fi
  done
