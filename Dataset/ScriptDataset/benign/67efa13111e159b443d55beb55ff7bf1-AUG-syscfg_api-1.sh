	name=$1
	new_value=$2
	current_value=`syscfg get "$name"`
	if [ "$current_value" != "$new_value" ]; then
		syscfg set "$name" "$new_value"
		sysevent set SYSCFG_DIRTY "1"
	fi
