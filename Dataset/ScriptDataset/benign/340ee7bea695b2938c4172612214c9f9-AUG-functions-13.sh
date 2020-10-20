	local section="$1"
	local option="$2"
	local value="$3"

	export ${NO_EXPORT:+-n} "CONFIG_${section}_${option}=${value}"
