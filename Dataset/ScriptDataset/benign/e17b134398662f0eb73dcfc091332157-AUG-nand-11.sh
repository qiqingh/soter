	local conf_tar="/tmp/sysupgrade.tgz"
	
	sync
	[ -f "$conf_tar" ] && nand_restore_config "$conf_tar"
	echo "sysupgrade successful"
	reboot -f
