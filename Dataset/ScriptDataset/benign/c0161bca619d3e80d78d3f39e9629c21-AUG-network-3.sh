	local __addr

	if __network_ifstatus "__addr" "$2" "['ipv6-address','ipv6-prefix-assignment'][0].address"; then
		case "$__addr" in
			*:)	export "$1=${__addr}1" ;;
			*)	export "$1=${__addr}" ;;
		esac
		return 0
	fi

	unset $1
	return 1
