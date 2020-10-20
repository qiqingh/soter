#!/bin/sh

. /lib/functions.sh
. ../netifd-proto.sh
init_proto "$@"

add_protocol dhcp
