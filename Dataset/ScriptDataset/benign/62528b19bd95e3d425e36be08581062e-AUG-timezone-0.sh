#!/bin/sh
# Copyright (C) 2014 Gemtek

. /usr/share/libubox/jshn.sh
. /lib/functions/network.sh
. /lib/functions.sh

CRONTAB_ROOT="/etc/crontabs/root"
NTP_SERVER=$(uci -q get system.ntp.server)


action=$1
case "$action" in
    start)
        start_tz ;;
    disable)
        disable_tz ;;
    none)
        exit 0;;
    *)
        usage ;;
esac

