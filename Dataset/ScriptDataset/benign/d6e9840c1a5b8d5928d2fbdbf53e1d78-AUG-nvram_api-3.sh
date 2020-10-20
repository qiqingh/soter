	name=$1
	current_value=`nvram get "$name"`
	echo "$current_value"
