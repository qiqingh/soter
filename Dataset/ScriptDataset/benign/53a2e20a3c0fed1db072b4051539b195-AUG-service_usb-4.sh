   [ -z "$1" ] && return
   get_usb_config_by_port_num $1
   SYSEVENT_usb_port_type=`sysevent get usb_port_${1}_type`
   SYSEVENT_usb_port_state=`sysevent get usb_port_${1}_state`
   ulog usb manager "$PID USB_current_mode = $USB_current_mode"
   provisioned_mode_to_desired_port_mode $USB_current_mode
   [ -z "$USB_desired_mode" ] && USB_desired_mode="detect"
   
   ulog usb manager "$PID USB_desired_mode = $USB_desired_mode"
   if [ "up" = "$SYSEVENT_usb_port_state" ] ; then
      if [ "used" = "$USB_desired_mode" ] ; then
         ulog usb service "$PID USB up: Configured for no special modes on usb port $1"
         if [ "storage" = "$SYSEVENT_usb_port_type" ] ; then
            syscfg set usb_${1}::current_mode storage
            add_storage_drivers
         elif [ "printer" = "$SYSEVENT_usb_port_type" ] ; then
            syscfg set usb_${1}::current_mode virtualUSB
            add_virtualusb_drivers
         elif [ "none" = "$SYSEVENT_usb_port_type" ] ; then
            syscfg set usb_${1}::current_mode detect
         fi
         sysevent set usb_port_${1}_state up
         return
      fi
      case "$USB_desired_mode" in
         storage)
            ulog usb service "$PID USB up: desired mode is Storage"
            lsmod | grep "usb_storage" ; 
            if [ "1" = "$?" ] ; then
               add_storage_drivers
               ulog usb service "$PID Adding storage drivers on usb port $1"
            fi
            ;;
         virtualUSB)
            ulog usb service "$PID USB up: desired mode is VirtualUSB"
            lsmod | grep "sxuptp" ; 
            if [ "1" = "$?" ] ; then
               add_virtualusb_drivers
               ulog usb service "$PID Adding virtual usb drivers on usb port $1"
            fi
            ;;
         detect)
            ulog usb service "$PID USB up: desired mode is Detect"
            if [ "storage" = "$SYSEVENT_usb_port_type" ] ; then
               lsmod | grep "usb_storage" ;
               if [ "1" = "$?" ]; then
                  add_storage_drivers
                  ulog usb service "$PID Adding storage drivers on usb port $1"
               else
                  ulog usb service "$PID storage drivers already installed on usb port $1"
               fi
            elif [ "printer" = "$SYSEVENT_usb_port_type" ] ; then
               lsmod | grep "sxuptp" ;
               if [ "1" = "$?" ] ; then
                  add_virtualusb_drivers
                  ulog usb service "$PID Adding virtual usb drivers on usb port $1"
               else
                  ulog usb service "$PID virtualUSB drivers already installed on usb port $1"
               fi
            fi
            ;;
         *)
            ulog usb service "$PID USB up: Unhandled case statement for mode $USB_desired_mode"
            ;;
      esac
   else
      if [ "used" = "$USB_desired_mode" ] ; then
         ulog usb service "$PID USB down: Configured for no special modes on usb port $1"
         if [ "storage" = "$SYSEVENT_usb_port_type" ] ; then
            syscfg set usb_${1}::current_mode storage
            add_storage_drivers 
            sysevent set usb_port_${1}_state up
         elif [ "printer" = "$SYSEVENT_usb_port_type" ] ; then
            syscfg set usb_${1}::current_mode virtualUSB
            add_virtualusb_drivers
            sysevent set usb_port_${1}_state up
         elif [ "none" = "$SYSEVENT_usb_port_type" ] ; then
            syscfg set usb_${1}::current_mode detect
            sysevent set usb_port_${1}_state detecting
         fi
         return
      fi
      case "$USB_desired_mode" in
         storage)
            ulog usb service "$PID USB down: desired mode is Storage"
            add_storage_drivers
            sysevent set usb_port_${1}_state up
            ;;
         virtualUSB)
            ulog usb service "$PID USB down: desired mode is VirtualUSB"
            add_virtualusb_drivers
            sysevent set usb_port_${1}_state up
            ;;
         detect)
            ulog usb service "$PID USB down: desired mode is Detect"
            if [ "none" = "$SYSEVENT_usb_port_type" ] ; then
               ulog usb service "$PID USB down: There is no usb on usb port $1"
               sysevent set usb_port_${1}_state detecting
            elif [ "storage" = "$SYSEVENT_usb_port_type" ] ; then
               lsmod | grep "usb_storage" ;
               if [ "1" = "$?" ] ; then
                  add_storage_drivers
                  ulog usb service "$PID USB down: Adding storage drivers on usb port $1"
               else
                  ulog usb service "$PID USB down: storage drivers already installed on usb port $1"
               fi
               sysevent set usb_port_${1}_state up
            elif [ "printer" = "$SYSEVENT_usb_port_type" ] ; then
               lsmod | grep "sxuptp" ;
               if [ "1" = "$?" ] ; then
                  add_virtualusb_drivers
                  ulog usb service "$PID USB down: Adding virtual usb drivers on usb port $1"
               else
                  ulog usb service "$PID USB down: virtual usb drivers already installed on usb port $1"
               fi
               sysevent set usb_port_${1}_state up
            fi
            ;;
         *)
            ulog usb service "$PID USB down: Unhandled case statement 2 for mode $USB_desired_mode"
            ;;
      esac
   fi
