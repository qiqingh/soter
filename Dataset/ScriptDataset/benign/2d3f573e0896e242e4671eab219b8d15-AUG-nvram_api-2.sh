	name=$1
	current_value=`nvram get "$name"`
	if [ ! -z "$current_value" ]; then
		nvram unset "$name"
		sysevent set NVRAM_DIRTY "1"
	fi
