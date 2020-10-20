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
		case $(board_name) in
		gl-ar300m|\
		gl-ar750)
			fw_printenv lc >/dev/null 2>&1 && fw_setenv "bootcount" 0
			;;
		qihoo-c301)
			local n=$(fw_printenv activeregion | cut -d = -f 2)
			fw_setenv "image${n}trynum" 0
			;;
		wi2a-ac200i)
			fw_setenv PKRstCnt 0
			;;
		esac
		;;
	esac
