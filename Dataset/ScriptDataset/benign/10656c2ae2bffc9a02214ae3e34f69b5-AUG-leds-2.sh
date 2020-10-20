	local label
	local ledpath=$(get_dt_led_path $1)

	[ -n "$ledpath" ] && \
		label=$(cat "$ledpath/label" 2>/dev/null) || \
		label=$(cat "$ledpath/chan-name" 2>/dev/null)

	echo "$label"
