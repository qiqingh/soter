	local _package="$1"
	local _type="$2"
	local _name="$3"
	local _result
	local _error
	shift; shift; shift
	_result=$(/sbin/validate_data "$_package" "$_type" "$_name" "$@" 2> /dev/null)
	_error=$?
	eval "$_result"
	[ "$_error" = "0" ] || $(/sbin/validate_data "$_package" "$_type" "$_name" "$@" 1> /dev/null)
	return $_error
