   [ -z "$1" ] && return
   sysevent set usb_port_${1}_type none
   sysevent set usb_port_${1}_state down
