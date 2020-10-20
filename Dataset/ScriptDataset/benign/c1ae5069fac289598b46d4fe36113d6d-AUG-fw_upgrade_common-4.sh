	handle_cbt_code_pattern $FW_PATH
	ret=$?
	if [ $ret -eq 0 ];then
		size=`ls -l $FW_PATH | awk '{print $5}'`
		#ignore 32 bytes code header
		bootimage=`fw_printenv bootimage`
		if [ "$bootimage" == "bootimage=1" ];then
			/sbin/mtd -o 32 -l $size write $FW_PATH firmware_2
			fw_setenv bootimage 2
		else
			/sbin/mtd -o 32 -l $size write $FW_PATH firmware
			fw_setenv bootimage 1
		fi
		ret=$?
		if [ $ret -eq 0 ];then
			echo "1" > /tmp/.fw_up_result
			nvram_set 2860 wz_fw_up_result 1
			nvram_commit 2860
			return 0
		fi
	fi
