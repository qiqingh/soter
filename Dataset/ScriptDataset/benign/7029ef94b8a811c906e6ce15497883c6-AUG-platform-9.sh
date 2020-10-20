	local image_magic="$(get_magic_long "$1")"
	local board_magic="$2"
	[ "$image_magic" != "$board_magic" ] && {
		echo "Invalid image magic '$image_magic'. Expected '$board_magic'."
		return 1
	}

	local model_string="$3"
	local trargs="$4"

	# New images have the support list at 7802888, old ones at 1511432
	tplink_pharos_check_support_list "$1" 7802888 "$model_string" "$trargs" || \
	tplink_pharos_check_support_list "$1" 1511432 "$model_string" "$trargs" || {
		echo "Unsupported image (model not in support-list)"
		return 1
	}

	return 0
