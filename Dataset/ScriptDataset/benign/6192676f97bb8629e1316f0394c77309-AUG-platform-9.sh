	get_image "$@" | dd bs=1 count=4 skip=53 2>/dev/null | hexdump -v -n 4 -e '1/1 "%02x"'
