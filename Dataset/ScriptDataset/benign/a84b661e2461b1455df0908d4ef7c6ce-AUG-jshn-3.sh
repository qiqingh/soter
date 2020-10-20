	# var=$1
	local value="$2"
	local sep="${3:- }"

	eval "export -- \"$1=\${$1:+\${$1}\${value:+\$sep}}\$value\""
