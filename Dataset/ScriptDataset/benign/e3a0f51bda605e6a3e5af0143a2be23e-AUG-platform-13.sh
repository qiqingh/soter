	local file_type=$(platform_identify "$1")
	local trx="$1"
	local cmd=

	[ "$(platform_flash_type)" == "nand" ] && {
		echo "Writing whole image to NAND flash. All erase counters will be lost."
	}

	case "$file_type" in
		"chk")		cmd=$(platform_trx_from_chk_cmd "$trx");;
		"cybertan")	cmd=$(platform_trx_from_cybertan_cmd "$trx");;
		"safeloader")	trx=$(platform_img_from_safeloader "$trx"); PART_NAME=os-image;;
		"seama")	trx=$(platform_img_from_seama "$trx");;
	esac

	default_do_upgrade "$trx" "$cmd"
