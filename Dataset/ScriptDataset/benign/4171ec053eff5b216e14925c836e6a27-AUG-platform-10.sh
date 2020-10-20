	local file_type=$(brcm47xx_identify "$1")
	local trx="$1"
	local cmd=""

	case "$file_type" in
		"chk")		cmd=$(platform_trx_from_chk_cmd "$trx");;
		"cybertan")	cmd=$(platform_trx_from_cybertan_cmd "$trx");;
		"lxl")		cmd=$(platform_trx_from_lxl_cmd "$trx");;
		"lxlold")	cmd=$(platform_trx_from_lxlold_cmd "$trx");;
	esac

	default_do_upgrade "$trx" "$cmd"
