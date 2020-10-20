#!/bin/sh

[ -L /sbin/udhcpc ] || exit 0

. /lib/functions.sh
. ../netifd-proto.sh
init_proto "$@"

add_protocol dhcp
