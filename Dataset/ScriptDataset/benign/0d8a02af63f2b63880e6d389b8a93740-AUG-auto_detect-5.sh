  cur=`sysevent get usb_port_${1}_class`
  
  echo "$cur" | grep -q "$2"
  
  if [ "$?" = "0" ] ; then
    return 0
  fi
  return 1
