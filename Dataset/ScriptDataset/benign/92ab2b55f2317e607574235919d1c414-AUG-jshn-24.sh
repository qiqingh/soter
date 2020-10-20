	local __dest="$1"
	local __cur

	_json_get_var __cur JSON_CUR
	local __var="${JSON_PREFIX}T_${__cur}_${2//[^a-zA-Z0-9_]/_}"
	eval "export -- \"$__dest=\${$__var}\"; [ -n \"\${$__var+x}\" ]"
