    [ -z "$1" ] && return
    ulog usb autodetect "$PID call get_usb_port_from_single_host $1"
    ls "$USB_DEVICES_DIR" | grep -q "[1-9]-[1-9].[1-9]$"
    [ "0" != "$?" ] && USB_port="1" && return
    echo "$1" | grep -q "[1-9]-[1-9].[1-9]$"
    if [ "0" = "$?" ] ; then
      USB_ID="$1"
    else
      USB_ID=`echo "$1" | awk -F "/" '{ for (i=1; i<=NF; i++) if ( $i ~ /[1-9]-[1-9].[1-9]$/ ) { print $i } }'`
    fi
    ulog usb autodetect "$PID single_usb_host(USB_ID)=$USB_ID"
    CUR_USB_PORT=`echo "$USB_ID" | cut -d '.' -f 2`
    ulog usb autodetect "$PID single_usb_host(CUR_USB_PORT)=$CUR_USB_PORT"
    [ "$CUR_USB_PORT" = "3" ] && USB_port="1" && return
    [ "$CUR_USB_PORT" = "4" ] && USB_port="2" && return
