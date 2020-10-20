#!/bin/sh

. /usr/share/libubox/jshn.sh
. /etc/openwrt_release

json_init
json_add_object firmware
json_add_string "id" "${DISTRIB_ID}"
json_add_string "release" "${DISTRIB_RELEASE}"
json_add_string "revision" "${DISTRIB_REVISION}"
json_add_string "codename" "${DISTRIB_CODENAME}"
json_add_string "target" "${DISTRIB_TARGET}"
json_add_string "description" "${DISTRIB_DESCRIPTION}"
json_close_object
ubus call embeddd probe "$(json_dump)"
