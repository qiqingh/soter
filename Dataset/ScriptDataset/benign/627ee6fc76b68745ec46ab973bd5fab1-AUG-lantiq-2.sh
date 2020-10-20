	local model

	[ -f /tmp/sysinfo/model ] && model=$(cat /tmp/sysinfo/model)
	[ -z "$model" ] && model="unknown"

	echo "$model"
