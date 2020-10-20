	(get_image "$@" | dd bs=8 count=1 skip=64) 2>/dev/null
