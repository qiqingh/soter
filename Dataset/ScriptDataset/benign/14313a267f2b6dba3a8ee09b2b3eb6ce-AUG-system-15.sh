	local mac="$1"
	local canon=""

	mac=$(echo -n $mac | tr -d \")
	[ ${#mac} -gt 17 ] && return
	[ -n "${mac//[a-fA-F0-9\.: -]/}" ] && return

	for octet in ${mac//[\.:-]/ }; do
		case "${#octet}" in
		1)
			octet="0${octet}"
			;;
		2)
			;;
		4)
			octet="${octet:0:2} ${octet:2:2}"
			;;
		12)
			octet="${octet:0:2} ${octet:2:2} ${octet:4:2} ${octet:6:2} ${octet:8:2} ${octet:10:2}"
			;;
		*)
			return
			;;
		esac
		canon=${canon}${canon:+ }${octet}
	done

	[ ${#canon} -ne 17 ] && return

	printf "%02x:%02x:%02x:%02x:%02x:%02x" 0x${canon// / 0x} 2>/dev/null
