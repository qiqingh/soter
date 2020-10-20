#!/bin/sh
FW="/tmp/firmware-speedport-w921v-1.46.000.bin"
URL="https://www.telekom.de/hilfe/downloads/firmware-speedport-w921v-1.46.000.bin"
FW_TAPI="vr9_tapi_fw.bin"
FW_DSL="vr9_dsl_fw_annex_b.bin"
MD5_FW="188734c0773b225f8c130984b279621a"
MD5_TAPI="57f2d07f59e11250ce1219bad99c1eda"
MD5_DSL="655442e31deaa42c9c68944869361ec0"

[ -f /lib/firmware/vdsl.bin ] && exit 0

[ -z "$1" ] || URL=$1

F=$(md5sum -b ${FW} | cut -d" " -f1)
cd /tmp
echo "Unpack and decompress w921v Firmware"

w921v_fw_cutter
[ $? -eq 0 ] || exit 1

T=$(md5sum -b ${FW_TAPI} | cut -d" " -f1)
D=$(md5sum -b ${FW_DSL} | cut -d" " -f1)

cp ${FW_TAPI} ${FW_DSL} /lib/firmware/