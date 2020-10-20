	case "$1" in
		preinit)
			set_led 1
		;;
		failsafe)
			set_led 2
		;;
		done)
			set_led 0
		;;
	esac
