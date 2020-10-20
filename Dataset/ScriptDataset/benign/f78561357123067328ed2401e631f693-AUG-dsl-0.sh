#!/bin/sh

. /usr/share/libubox/jshn.sh

json_init
json_add_object "dsl"

json_add_string "name" "vdsl"

json_add_array "xfer_mode"
json_add_string "" "ptm"
json_add_string "" "atm"
json_close_array

json_add_array "annex"
json_add_string "" "a"
json_add_string "" "b"
json_add_string "" "j"
json_close_array

json_add_array "tone"
json_add_string "" "a"
json_add_string "" "b"
json_add_string "" "av"
json_add_string "" "bv"
json_close_array

json_close_object

ubus call embeddd probe "$(json_dump)"
