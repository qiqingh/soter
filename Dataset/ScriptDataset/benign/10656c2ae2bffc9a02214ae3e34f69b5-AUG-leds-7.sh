	local trigger
	local ledpath=$(get_dt_led_path $1)

	[ -n "$ledpath" ] && \
		trigger=$(cat "$ledpath/linux,default-trigger" 2>/dev/null)

	[ -n "$trigger" ] && \
		led_set_attr "$(get_dt_led $1)" "trigger" "$trigger"
