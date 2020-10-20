#!/bin/sh
op_mode=`xmldbc -g /device/layout`
if [ "$1" = "EXTENDER" -a "$op_mode" != "bridge" -o "$1" = "ROUTER" -a "$op_mode" != "router" ]; then
	event REBOOT
fi
