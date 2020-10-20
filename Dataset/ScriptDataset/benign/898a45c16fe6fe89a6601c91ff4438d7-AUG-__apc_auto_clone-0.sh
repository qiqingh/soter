#!/bin/sh
echo [$0] ... > /dev/console
TROOT=`rgdb -i -g /runtime/template_root`
[ "$TROOT" = "" ] && TROOT="/etc/templates"
rgdb -A /etc/templates/apc_auto_clone.php > /var/run/apc_auto_clone.sh
sh /var/run/apc_auto_clone.sh
WISP=`rgdb -g /bridge`
if [ $WISP -eq 0 ]; then
	sleep 3
	echo "Start RG ..."     > /dev/console
	/etc/templates/rg.sh start  > /dev/console
	echo "Start DNRD ..."       > /dev/console
	/etc/templates/dnrd.sh start    > /dev/console
	echo "Start UPNPD ..."      > /dev/console
	/etc/templates/upnpd.sh start   > /dev/console
	echo "start WAN_APC ..."        > /dev/console
	/etc/templates/wan_apc.sh start > /dev/console
fi
