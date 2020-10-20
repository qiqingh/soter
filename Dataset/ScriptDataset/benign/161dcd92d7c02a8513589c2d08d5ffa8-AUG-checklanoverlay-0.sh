#!/bin/sh

. /usr/share/libubox/jshn.sh
. /lib/functions/network.sh
. /lib/functions.sh
. /lib/functions/gemtek.sh

log "Start overlay check"

json_load "$(objReq lan json)"
json_select "LanP"
json_get_var LANIP ipaddr
json_get_var LANMASK netmask

network_get_ipaddr WANIP wan
network_get_subnet WANMASK wan
if [ -n "$WANMASK" -a -n "$WANIP" ]; then
	MASKNUM=`echo $WANMASK | cut -d '/' -f 2`
	[ -z "$MASKNUM" ] && { MASKNUM='24'; }
	masknumtoaddr $MASKNUM WANMASK
	WanIsOverlay="$(check_overlay $WANIP $WANMASK $LANIP $LANMASK)"
	log "Can't get wan netmask, skip check!!!"
fi
