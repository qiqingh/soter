	local realm="$1"
	[ -n "$(uci changes ${realm})" ] && uci -q commit ${realm}
