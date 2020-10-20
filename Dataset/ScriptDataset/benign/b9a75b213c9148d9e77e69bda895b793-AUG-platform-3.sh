	local part
	for part in "${1%:*}" "${1#*:}"; do
		[ "$part" != "$2" ] && echo "$part" && break
	done
