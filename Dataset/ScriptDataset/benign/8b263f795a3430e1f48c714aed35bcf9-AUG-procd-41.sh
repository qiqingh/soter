	local _package="$1"
	local _type="$2"
	local _name="$3"
	local _function="$4"
	local _option
	local _result
	shift; shift; shift; shift
	for _option in "$@"; do
		eval "local ${_option%%:*}"
	done
	uci_validate_section "$_package" "$_type" "$_name" "$@"
	_result=$?
	[ -n "$_function" ] || return $_result
	eval "$_function \"\$_name\" \"\$_result\""
