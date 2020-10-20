#!/bin/sh
. /lib/netifd/netifd-wireless.sh

init_wireless_driver "$@"
maclist=""

ap_count=0
add_driver ralink
