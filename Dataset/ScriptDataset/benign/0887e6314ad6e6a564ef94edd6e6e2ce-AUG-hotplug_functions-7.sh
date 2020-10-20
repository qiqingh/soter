    [ -z "$1" ] && return
    ulog usb autodetect "$PID get_usb_port_from_multiple_host $1"
    get_syscfg_UsbPortCount
    if [ "$SYSCFG_UsbPortCount" = "2" ] ; then
        echo "$1" | grep -q "$USB1_ROOT_HUB"
        [ "0" = "$?" ] && USB_port="1" && return
        echo "$1" | grep -q "$USB2_ROOT_HUB"
        [ "0" = "$?" ] && USB_port="2" && return
        echo "$1" | grep -q "$USB3_ROOT_HUB"
        [ "0" = "$?" ] && USB_port="2" && return
        echo "$1" | grep -q "$USB_CTRL_1_1"
        [ "0" = "$?" ] && USB_port="1" && return
        echo "$1" | grep -q "$USB_CTRL_1_2"
        [ "0" = "$?" ] && USB_port="2" && return
        echo "$1" | grep -q "$USB_CTRL_2_1"
        [ "0" = "$?" ] && USB_port="1" && return
        echo "$1" | grep -q "$USB_CTRL_2_2"
        [ "0" = "$?" ] && USB_port="2" && return
        echo "$1" | grep -q "$USB_CTRL_3_1"
        [ "0" = "$?" ] && USB_port="1" && return
        echo "$1" | grep -q "$USB_CTRL_3_2"
        [ "0" = "$?" ] && USB_port="2" && return
    else
        USB_port="1"
    fi
