	[ "$#" -ge 2 ] || return 0
	local function="$1"; shift
	local target="$1"; shift
	local type val

	json_get_type type "$target"
	case "$type" in
		object|array)
			local keys key
			json_select "$target"
			json_get_keys keys
			for key in $keys; do
				json_get_var val "$key"
				eval "$function \"\$val\" \"\$key\" \"\$@\""
			done
			json_select ..
		;;
		*)
			json_get_var val "$target"
			eval "$function \"\$val\" \"\" \"\$@\""
		;;
	esac
