	name=$1
	current_value=`syscfg get "$name"`
	echo "$current_value"
