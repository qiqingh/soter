	case "$(config_get led_dsl trigger)" in
	"netdev")
		led_set_attr $1 "trigger" "netdev"
		led_set_attr $1 "device_name" "$(config_get led_dsl dev)"
		for m in $(config_get led_dsl mode); do
			led_set_attr $1 "$m" "1"
		done
		;;
	*)
		led_on $1
		;;
	esac
