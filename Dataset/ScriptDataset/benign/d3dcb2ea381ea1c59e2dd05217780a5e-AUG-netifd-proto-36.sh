	local var="VAR${_EXPORT_VAR}"
	_EXPORT_VAR="$(($_EXPORT_VAR + 1))"
	export -- "$var=$1"
	append _EXPORT_VARS "$var"
