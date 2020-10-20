	local from="$1"
	local cat="$2"

	if [ -z "$cat" ]; then
		local magic="$(dd if="$from" bs=2 count=1 2>/dev/null | hexdump -n 2 -e '1/1 "%02x"')"
		case "$magic" in
			1f8b) cat="zcat";;
			425a) cat="bzcat";;
			*) cat="cat";;
		esac
	fi

	$cat "$from" 2>/dev/null
