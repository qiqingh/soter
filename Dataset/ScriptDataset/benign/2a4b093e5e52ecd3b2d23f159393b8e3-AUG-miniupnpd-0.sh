#!/bin/sh

. /usr/share/libubox/jshn.sh
. /lib/functions/network.sh
. /lib/functions.sh
. /lib/hummer/state.sh

MFG_MODE=$(gcontrol uenv get ManufactureMode | awk -F"=" '{print $2}')
[ -z $MFG_MODE ] && { MFG_MODE="0"; }
WANIF=`uci -q get network.wan.ifname`
LANIP=`uci -q get network.lan.ipaddr`
LANMASK=`uci -q get network.lan.netmask`
MINIUPNPDUUID=`gcontrol di get uuid_key | awk -F"=" '{print $2}'`
SHOWNAME=`cat /tmp/devinfo/default_ssid`
if [ -z $SHOWNAME ]; then
	SHOWNAME="Linksys Router"
else
	json_load "$(objReq lan json)"
	json_select LanP
	json_get_vars routername
	[ "$routername" != "$SHOWNAME" ] && { SHOWNAME=$routername; }
fi

MODELNAME=`cat /tmp/devinfo/modelNumber`
SN=`cat /tmp/devinfo/serial_number`

USERCONF="1"
USERDISCONNECT="0"

action=$1
actif=$2
case "$action" in
    start)
            if [ -z $2 ]; then
                start_upnp
            elif [ "$2" == "ra0" -o "$2" == "rai0" ]; then
                start_upnp $2
            fi
	    ;;
    stop)
            if [ -z $2 ]; then
                stop_upnp
            elif [ "$2" == "ra0" -o "$2" == "rai0" ]; then
                stop_upnp $2
            fi
	    ;;
    restart)
            stop_upnp
	    start_upnp
	    ;;
    wanchange)
            send_wanchnage
            ;;
    *)
            usage ;;
esac

