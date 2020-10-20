	# var=$1
	local _a_value="$2"
	eval "${JSON_PREFIX}$1=\"\${${JSON_PREFIX}$1} \$_a_value\""
