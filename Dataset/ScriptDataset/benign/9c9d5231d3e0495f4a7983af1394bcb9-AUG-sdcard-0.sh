get_magic_at() {
	local file="$1"
	local pos="$2"
	get_image "$file" | dd bs=1 count=2 skip="$pos" 2>/dev/null | hexdump -v -n 2 -e '1/1 "%02x"'
}

