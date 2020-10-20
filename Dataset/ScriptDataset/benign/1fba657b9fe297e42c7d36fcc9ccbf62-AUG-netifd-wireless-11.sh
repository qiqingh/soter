	while [ -n "$1" ]; do
		local var="${1%%=*}"
		local val="$1"
		shift
		[[ "$var" = "$val" ]] && continue
		val="${val#*=}"
		json_add_string "$var" "$val"
	done
