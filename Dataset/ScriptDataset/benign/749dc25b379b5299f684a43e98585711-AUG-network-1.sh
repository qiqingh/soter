	local __tmp

	[ -z "$__NETWORK_CACHE" ] && {
		__tmp="$(ubus call network.interface dump 2>&1)"
		case "$?" in
			4) : ;;
			0) export __NETWORK_CACHE="$__tmp" ;;
			*) echo "$__tmp" >&2 ;;
		esac
	}

	__tmp="$(jsonfilter ${4:+-F "$4"} ${5:+-l "$5"} -s "${__NETWORK_CACHE:-{}}" -e "$1=@.interface${2:+[@.interface='$2']}$3")"

	[ -z "$__tmp" ] && \
		unset "$1" && \
		return 1

	eval "$__tmp"
