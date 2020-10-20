	local __s_var="$1"
	local __s_val="$2"
	eval "export -- \"$__s_var=\${$__s_var:-\$__s_val}\""
