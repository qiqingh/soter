	local file_type=$(platform_identify "$1")

	[ "$(platform_flash_type)" != "nand" ] && return

	# Find trx offset
	case "$file_type" in
		"chk")		platform_pre_upgrade_trx "$1" $((0x$(get_magic_long_at "$1" 4)));;
		"cybertan")	platform_pre_upgrade_trx "$1" 32;;
		"seama")	platform_pre_upgrade_seama "$1";;
		"trx")		platform_pre_upgrade_trx "$1";;
	esac
