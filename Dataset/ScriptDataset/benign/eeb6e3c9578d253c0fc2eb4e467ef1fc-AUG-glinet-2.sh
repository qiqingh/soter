	mkdir -p /var/lock
	! glinet_using_boot_dev_switch && \
		fw_setenv bootcount 0 &&  \
		>&2 echo "Next boot set for NAND"
