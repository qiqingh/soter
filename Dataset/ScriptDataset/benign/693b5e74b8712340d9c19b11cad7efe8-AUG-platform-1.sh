	bootsys=$(fw_printenv bootsys | awk -F= '{{print $2}}')
	newbootsys=2
	if [ "$bootsys" -eq "2" ]; then
		newbootsys=1
	fi

	# If nand_do_upgrade succeeds, we don't have an opportunity to add any actions of
	# our own, so do it here and set back on failure
	echo "Setting bootsys to #${newbootsys}"
	fw_setenv bootsys $newbootsys
	CI_UBIPART="nandubi"
	CI_KERNPART="kernel${newbootsys}"
	CI_ROOTPART="rootfs${newbootsys}"
	nand_do_upgrade "$ARGV" || (echo "Upgrade failed, setting bootsys ${bootsys}" && fw_setenv bootsys $bootsys)

