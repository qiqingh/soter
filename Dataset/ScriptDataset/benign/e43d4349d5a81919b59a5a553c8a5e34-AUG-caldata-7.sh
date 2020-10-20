	local expected="$1"
	local target=$2

	[ -n "$target" ] || target=/lib/firmware/$FIRMWARE

	magic=$(hexdump -v -n 2 -e '1/1 "%02x"' $target)
	[ "$magic" = "$expected" ]
	return $?
