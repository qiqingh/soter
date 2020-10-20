	handle_cbt_download_fw
	ret=$?
	if [ $ret -eq 0 ];then
		nvram_set 2860 action_service auto_fw_upgrade
		#fw_upgrade_status 0:no run 1:wait for mtd write
		nvram_set 2860 fw_upgrade_status 1
		nvram_set 2860 fw_check_status 0
		nvram_set 2860 next_check_time 0
		killall -1 nvram_daemon
		return 0
	else
		cur_hourhr=`date +%H`
		cur_minute=`date +%M`
		if [ $cur_hourhr -ge 3 -a $cur_minute -ge 55 ];then
			nvram_set 2860 fw_check_status 0
			nvram_set 2860 next_check_time 0
			nvram_set 2860 install_now 0
			nvram_set 2860 install_time 0
			nvram_commit 2860
		fi
	fi
