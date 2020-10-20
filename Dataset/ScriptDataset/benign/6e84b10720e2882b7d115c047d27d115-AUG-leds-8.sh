	led_morse $status_led "$1" "$2"
	[ -n "$status_led2" ] && led_morse $status_led2 "$1" "$2"
