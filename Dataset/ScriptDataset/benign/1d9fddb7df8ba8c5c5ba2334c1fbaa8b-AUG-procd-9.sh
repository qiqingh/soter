	while [ -n "$1" ]; do
		local var="${1%%=*}"
		local val="${1#*=}"
		[ "$1" = "$val" ] && val=
		json_add_string "$var" "$val"
		shift
	done
