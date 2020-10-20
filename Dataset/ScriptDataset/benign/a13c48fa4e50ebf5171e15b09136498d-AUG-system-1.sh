	local path="$1"
	local offset="$2"

	if [ -z "$path" ]; then
		echo "get_mac_binary: file $path not found!" >&2
		return
	fi

	hexdump -v -n 6 -s $offset -e '5/1 "%02x:" 1/1 "%02x"' $path 2>/dev/null
