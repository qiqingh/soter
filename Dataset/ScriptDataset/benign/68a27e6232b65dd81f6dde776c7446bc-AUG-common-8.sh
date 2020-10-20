	local from="$1"
	local cmd="$2"

	if [ -z "$cmd" ]; then
		local magic="$(dd if="$from" bs=2 count=1 2>/dev/null | hexdump -n 2 -e '1/1 "%02x"')"
		case "$magic" in
			1f8b) cmd="zcat";;
			425a) cmd="bzcat";;
			*) cmd="cat";;
		esac
	fi

	cat "$from" 2>/dev/null | $cmd
