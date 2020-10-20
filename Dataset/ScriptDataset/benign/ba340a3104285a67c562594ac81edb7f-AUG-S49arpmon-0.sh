#!/bin/sh
echo [$0]: $1 ... > /dev/console
LAYOUT=`xmldbc -g /device/layout`
if [ "$LAYOUT" == "bridge" ] ; then
arpmonitor -i br0 -b &
else
arpmonitor -i br0 &
fi
