	local var="$1"
	local val="$(($2 / 100))"
	append $var "$val" " "
