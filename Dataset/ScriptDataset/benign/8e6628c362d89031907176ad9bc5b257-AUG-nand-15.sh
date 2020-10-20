	if [ -n "$IS_PRE_UPGRADE" ]; then
		# Previously, nand_do_upgrade was called from the platform_pre_upgrade
		# hook; this piece of code handles scripts that haven't been
		# updated. All scripts should gradually move to call nand_do_upgrade
		# from platform_do_upgrade instead.
		export do_upgrade="nand_do_upgrade '$1'"
		return
	fi

	local file_type=$(identify $1)

	if type 'platform_nand_pre_upgrade' >/dev/null 2>/dev/null; then
		platform_nand_pre_upgrade "$1"
	fi

	[ ! "$(find_mtd_index "$CI_UBIPART")" ] && CI_UBIPART="rootfs"

	case "$file_type" in
		"ubi")		nand_upgrade_ubinized $1;;
		"ubifs")	nand_upgrade_ubifs $1;;
		*)		nand_upgrade_tar $1;;
	esac
