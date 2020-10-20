    if [ -n "$1" ] ; then
      get_usb_config_by_port_num $1
      SYSEVENT_usb_port_type=`sysevent get usb_port_${1}_type`
      SYSEVENT_usb_port_state=`sysevent get usb_port_${1}_state`
      SYSEVENT_usb_port_device=`sysevent get usb_port_${1}_device`
    else
      USB_friendly_name=
      USB_current_mode=
      SYSEVENT_usb_port_type=
      SYSEVENT_usb_port_state=
      SYSEVENT_usb_port_device=
    fi
