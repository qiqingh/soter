  cur=`sysevent get usb_port_${1}_class`
  if [ -z "$cur" ] ; then
    sysevent set usb_port_${1}_class $2
  else
    sysevent set usb_port_${1}_class "$cur $2"
  fi
