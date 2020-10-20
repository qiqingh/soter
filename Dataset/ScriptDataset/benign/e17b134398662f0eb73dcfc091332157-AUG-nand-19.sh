	echo -n $1 > /tmp/sysupgrade-nand-path
	cp /sbin/upgraded /tmp/
	nand_upgrade_stage1
