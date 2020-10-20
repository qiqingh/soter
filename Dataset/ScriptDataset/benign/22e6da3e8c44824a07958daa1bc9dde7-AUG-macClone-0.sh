#!/bin/sh

. /usr/share/libubox/jshn.sh
. /lib/functions/network.sh
. /lib/functions.sh


action=$1
case "$action" in
    start)
            start_macClone ;;
    *)
            usage ;;
esac

