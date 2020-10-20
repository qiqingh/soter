#!/bin/sh

. /sbin/fw_upgrade_common.sh

handle_cbt_download_fw
ret=$?
if [ $ret -eq 0 ];then
	mtd_write_fw
	return 0
fi
echo "0" >/tmp/.fw_up_result
nvram_set 2860 wz_fw_up_result 0
nvram_commit 2860
