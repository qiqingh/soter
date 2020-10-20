#!/bin/sh
[ -n "$1" ] && routefile=$1 || routefile="/tmp/udhcpstaticroutes"

rm -rf ${routefile}

[ -n "$staticroutes" ] && set_classless_routes $staticroutes
[ -n "$msstaticroutes" ] && set_classless_routes $msstaticroutes
[ -n "$routes" ] && set_dhcp_routes $routes 
