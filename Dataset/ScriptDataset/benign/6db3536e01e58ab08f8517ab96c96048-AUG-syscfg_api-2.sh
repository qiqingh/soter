	name=$1
	commit=$2
	current_value=`syscfg get "$name"`
	if [ ! -z "$current_value" ]; then
		syscfg unset "$name"
		sysevent set SYSCFG_DIRTY "1"
	fi
