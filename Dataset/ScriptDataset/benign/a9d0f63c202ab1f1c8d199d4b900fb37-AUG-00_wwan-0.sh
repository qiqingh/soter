#!/bin/sh

[ "$ACTION" = add -a "$DEVTYPE" = usb_device ] || exit 0

. /lib/functions.sh
. /lib/netifd/netifd-proto.sh

vid=$(cat /sys$DEVPATH/idVendor)
pid=$(cat /sys$DEVPATH/idProduct)
[ -f "/lib/network/wwan/$vid:$pid" ] || exit 0

config_load network
config_foreach find_wwan_iface interface
