	local _tmp
	config_get _tmp "$2" "$3" "$4"
	case "$_tmp" in
		1|on|true|yes|enabled) _tmp=1;;
		0|off|false|no|disabled) _tmp=0;;
		*) _tmp="$4";;
	esac
	export ${NO_EXPORT:+-n} "$1=$_tmp"
