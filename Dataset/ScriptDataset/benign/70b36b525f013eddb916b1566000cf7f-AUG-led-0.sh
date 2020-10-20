#!/bin/sh
# (C) 2008 openwrt.org

. /lib/functions.sh
ACTION=$1
NAME=$2
[ "$1" = "clear" -o "$1" = "set" ] &&
