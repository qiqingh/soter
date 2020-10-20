  mount | grep -q "sd[a-z]"
  if [ "0" = "$?" ] ; then
    return
  fi
  DEVS=`ls /dev/ | grep "sd[a-z][0-9]"`
  
  for d in $DEVS 
  do
    if Hotplug_IsDeviceStorage $d ; then
      Hotplug_GetId $d
      ulog usb autodetect "$PID check_mounted_usb_drives: $d on $DEVICE_PORT"
      `$STORAGE_DEVICE_SCRIPT add $d $DEVICE_PORT`
      sleep 1
    fi
  done
