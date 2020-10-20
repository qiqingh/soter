#!/bin/sh

. /lib/functions.sh

local mode

config_load embedd
config_get mode wan mode

current=`cat /tmp/current_mode`

[ "$mode" == "$current" -a "$mode" != "wifi" ] && return 0

logger -t wan_mode "$current -> $mode"

[ -f /etc/mode.d/$current ] && /etc/mode.d/$current stop
[ -f /etc/mode.d/$mode ] && /etc/mode.d/$mode start

echo $mode > /tmp/current_mode
uci commit

reload_config
/etc/init.d/igmpproxy reload

ubus call led set_state "{ \"net_mode\": \"$mode\" }"
