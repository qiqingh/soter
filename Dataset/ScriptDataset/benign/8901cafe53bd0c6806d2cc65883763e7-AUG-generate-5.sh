	option_cb() {
		return 0
	}

	# Section start
	case "$1" in
		interface)
			config_set "$2" "classgroup" "Default"
			config_set "$2" "upload" "128"
		;;
		classify|default|reclassify)
			option_cb() {
				append options "$1"
			}
		;;
	esac

    # Section end
	config_get TYPE "$CONFIG_SECTION" TYPE
	case "$TYPE" in
		interface)
			config_get_bool enabled "$CONFIG_SECTION" enabled 1
			[ 1 -eq "$enabled" ] || return 0
			config_get classgroup "$CONFIG_SECTION" classgroup
			config_set "$CONFIG_SECTION" ifbdev "$C"
			C=$(($C+1))
			append INTERFACES "$CONFIG_SECTION"
			config_set "$classgroup" enabled 1
			config_get device "$CONFIG_SECTION" device
			[ -z "$device" ] && {
				device="$(find_ifname ${CONFIG_SECTION})"
				config_set "$CONFIG_SECTION" device "$device"
			}
		;;
		classgroup) append CG "$CONFIG_SECTION";;
		classify|default|reclassify)
			case "$TYPE" in
				classify) var="ctrules";;
				*) var="rules";;
			esac
			config_get target "$CONFIG_SECTION" target
			config_set "$CONFIG_SECTION" options "$options"
			append "$var" "$CONFIG_SECTION"
			unset options
		;;
	esac
