	local prefix="$1"
	local valid="$2"
	local preferred="$3"

	if [ -z "$valid" ]; then
		append PROTO_PREFIX6 "$prefix"
	else
		[ -z "$preferred" ] && preferred="$valid"
		append PROTO_PREFIX6 "$prefix,$valid,$preferred"
	fi
