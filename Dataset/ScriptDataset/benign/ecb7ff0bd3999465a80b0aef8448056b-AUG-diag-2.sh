	get_status_led

	case "$1" in
	preinit)
		status_led_blink_preinit
		;;

	failsafe)
		status_led_blink_failsafe
		;;

	preinit_regular)
		status_led_blink_preinit_regular
		;;

	done)
		status_led_on
		;;
	esac
