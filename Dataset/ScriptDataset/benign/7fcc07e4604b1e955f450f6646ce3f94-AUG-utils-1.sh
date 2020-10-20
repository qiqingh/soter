	local var="$1"
	local value="$2"
	local sep="${3:- }"

	eval "export -- \"$var=\${$var:+\${$var}\${value:+\$sep}}\$value\""
