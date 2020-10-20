	get_status_led

	case "$1" in
	preinit)
		status_led_set_timer 100 100
		;;
	failsafe)
		status_led_set_timer 50 50
		;;
	preinit_regular)
		status_led_blink_preinit_regular
		;;
	done)
		[ "$status_led" = "status" ] && {
			status_led_set_heartbeat
		}
		[ "$status_led" = "power:green" ] && {
			status_led_set_on
			led_off "power:red"
		}
		;;
	esac
