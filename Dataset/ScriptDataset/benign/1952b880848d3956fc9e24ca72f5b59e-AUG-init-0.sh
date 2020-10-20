#!/bin/sh
#
# script file to start network
#
# Usage: init.sh {gw | ap} {all | bridge | wan}
#
TOOL=flash
GETMIB="$TOOL get"


sysconf init $*
#for graphical Auth
eval `$GETMIB GRAPH_AUTH`

if [ "$GRAPH_AUTH" = "1" ]; then
genCaptCha /web/images/bmp /tmp
fi

#init zero config, it must be the last call
zcip -v br0 zcip.sh &
