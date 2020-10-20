	local __dest="$1"
	local _tbl_cur

	if [ -n "$2" ]; then
		json_get_var _tbl_cur "$2"
	else
		_json_get_var _tbl_cur JSON_CUR
	fi
	local __var="${JSON_PREFIX}K_${_tbl_cur}"
	eval "export -- \"$__dest=\${$__var}\"; [ -n \"\${$__var+x}\" ]"
