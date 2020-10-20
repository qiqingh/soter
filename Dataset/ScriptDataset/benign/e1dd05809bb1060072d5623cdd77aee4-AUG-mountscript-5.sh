  storage_devices=`sysevent get usb_storage_devices`
  if [ -z "$storage_devices" ] ; then
    sysevent set usb_storage_devices "$1"
  else
    echo "$storage_devices" | grep -q "$1"
    if [ "$?" != "0" ] ; then
      sysevent set usb_storage_devices "$storage_devices $1"
    fi
  fi
  partitions=`sysevent get usb_${1}_partitions`
  if [ -z "$partitions" ] ; then
    sysevent set usb_${1}_partitions "$2"
  else
    sysevent set usb_${1}_partitions "$partitions $2"
  fi
  dlabel=`usblabel $2`
  dsize=`get_usb_size $2`
  sysevent set usb_${2}_status "$3"
  sysevent set usb_${2}_label "$dlabel"
  sysevent set usb_${2}_fstype "$4"
  sysevent set usb_${2}_sizes "$dsize" 
