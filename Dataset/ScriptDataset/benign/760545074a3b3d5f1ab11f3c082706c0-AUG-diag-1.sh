	local state="$1"
	[ -f "/proc/adm8668/sesled" ] && echo "$state" > "/proc/adm8668/sesled"
