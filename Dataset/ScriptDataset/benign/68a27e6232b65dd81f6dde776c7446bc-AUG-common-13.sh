	local magic=$(get_magic_gpt "$@")
	[ "$magic" = "EFI PART" ]
