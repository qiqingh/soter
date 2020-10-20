	local file_type=$(platform_identify "$1")
	local trx="$1"
	local cmd=

	[ "$(platform_flash_type)" == "nand" ] && {
		case "$file_type" in
			"chk")		platform_do_upgrade_nand_trx "$1" $((0x$(get_magic_long_at "$1" 4)));;
			"cybertan")	platform_do_upgrade_nand_trx "$1" 32;;
			"lxl")		platform_do_upgrade_nand_trx "$1" $(get_le_long_at "$1" 8);;
			"lxlold")	platform_do_upgrade_nand_trx "$1" 64;;
			"seama")	platform_do_upgrade_nand_seama "$1";;
			"trx")		platform_do_upgrade_nand_trx "$1";;
		esac

		# Above calls exit on success.
		# If we got here something went wrong.
		echo "Writing whole image to NAND flash. All erase counters will be lost."
	}

	case "$file_type" in
		"chk")		cmd=$(platform_trx_from_chk_cmd "$trx");;
		"cybertan")	cmd=$(platform_trx_from_cybertan_cmd "$trx");;
		"lxl")		cmd=$(platform_trx_from_lxl_cmd "$trx");;
		"lxlold")	cmd=$(platform_trx_from_lxlold_cmd "$trx");;
		"safeloader")	trx=$(platform_img_from_safeloader "$trx"); PART_NAME=os-image;;
		"seama")	trx=$(platform_img_from_seama "$trx");;
	esac

	default_do_upgrade "$trx" "$cmd"
