	local expected="$1"

	magic=$(hexdump -v -n 2 -e '1/1 "%02x"' /lib/firmware/$FIRMWARE)
	[ "$magic" = "$expected" ]
	return $?
