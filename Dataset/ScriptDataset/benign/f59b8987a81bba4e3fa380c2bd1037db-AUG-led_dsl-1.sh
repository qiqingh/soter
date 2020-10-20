	case "$(config_get led_dsl trigger)" in
	"netdev")
		led_set_attr $1 "trigger" "netdev"
		led_set_attr $1 "device_name" "$(config_get led_dsl dev)"
		led_set_attr $1 "mode" "$(config_get led_dsl mode)"
		;;
	*)
		led_on $1
		;;
	esac
