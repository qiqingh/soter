  storage_devices=`sysevent get usb_storage_devices`
  
  if [ -n "$storage_devices" ] ; then
    echo "$storage_devices" | grep -q "$1$"
    if [ "$?" = "0" ] ; then
      storage_devices=`echo $storage_devices | sed "s/$1//g"`
    else
      storage_devices=`echo $storage_devices | sed "s/$1 //g"`
    fi
    sysevent set usb_storage_devices "$storage_devices"
  fi
  partitions=`sysevent get usb_${1}_partitions`
  
  if [ -n "$partitons" ] ; then
    for part in $partitons 
    do
      sysevent set usb_${part}_status
      sysevent set usb_${part}_label
      sysevent set usb_${part}_fstype
      sysevent set usb_${part}_sizes
    done
  fi
  sysevent set usb_${1}_info
  sysevent set usb_${1}_partitions
