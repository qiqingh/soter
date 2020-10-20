	cur_boot_part=`/usr/sbin/fw_printenv -n boot_part`
	target_firmware=""
	if [ "$cur_boot_part" = "1" ]
	then
		# current primary boot - update alt boot
		target_firmware="kernel2"
		fw_setenv boot_part 2
		#In EA8500 bootcmd is always "bootipq", so don't change
		#fw_setenv bootcmd "run altnandboot"
	elif [ "$cur_boot_part" = "2" ]
	then
		# current alt boot - update primary boot
		target_firmware="kernel1"
		fw_setenv boot_part 1
		#In EA8500 bootcmd is always "bootipq", so don't change
		#fw_setenv bootcmd "run nandboot"
	fi

	# re-enable recovery so we get back if the new firmware is broken
	fw_setenv auto_recovery yes

	echo "$target_firmware"
