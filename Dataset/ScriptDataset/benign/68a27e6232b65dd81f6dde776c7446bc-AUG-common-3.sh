	local arg="$1"; shift
	for func in "$@"; do
		eval "$func $arg"
	done
