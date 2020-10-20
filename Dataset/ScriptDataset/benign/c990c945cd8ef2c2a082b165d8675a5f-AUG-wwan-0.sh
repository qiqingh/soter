#!/bin/sh

. /lib/functions.sh
. ../netifd-proto.sh
init_proto "$@"

INCLUDE_ONLY=1

ctl_device=""
dat_device=""

proto_mbim_setup() { echo "wwan[$$] mbim proto is missing"; }
proto_qmi_setup() { echo "wwan[$$] qmi proto is missing"; }
proto_ncm_setup() { echo "wwan[$$] ncm proto is missing"; }
proto_3g_setup() { echo "wwan[$$] 3g proto is missing"; }
proto_directip_setup() { echo "wwan[$$] directip proto is missing"; }

[ -f ./mbim.sh ] && . ./mbim.sh
[ -f ./ncm.sh ] && . ./ncm.sh
[ -f ./qmi.sh ] && . ./qmi.sh
[ -f ./3g.sh ] && { . ./ppp.sh; . ./3g.sh; }
[ -f ./directip.sh ] && . ./directip.sh

add_protocol wwan
