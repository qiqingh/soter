	name=$1
	new_value=$2
	current_value=`nvram get "$name"`
	if [ "$current_value" != "$new_value" ]; then
		nvram set "$name"="$new_value"
		sysevent set NVRAM_DIRTY "1"
	fi
