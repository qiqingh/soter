	local magic_long="$(get_magic_long "$1")"
	[ "$magic_long" != "7f454c46" ] && {
		echo "Invalid image magic '$magic_long'"
		return 1
	}

	local model_string="$(tplink_pharos_get_model_string)"

	# New images have the support list at 7802888, old ones at 1511432
	tplink_pharos_check_support_list "$1" 7802888 "$model_string" || \
	tplink_pharos_check_support_list "$1" 1511432 "$model_string" || {
		echo "Unsupported image (model not in support-list)"
		return 1
	}

	return 0
