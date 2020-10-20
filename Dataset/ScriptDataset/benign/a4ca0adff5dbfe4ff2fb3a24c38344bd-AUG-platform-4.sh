	local board=$(ramips_board_name)
	led=

	case "$board" in
	wsr-600) led="wsr-600:green:power";;
	wsr-1166) led="wsr-1166:green:power";;
	esac
	[ -n "$led" ] && {
		. /lib/functions/leds.sh
		echo 0 > /sys/class/leds/$led/brightness
		status_led="$led"
		status_led_blink_preinit
	}
	default_do_upgrade "$ARGV"
