	init_coexistence
	case ${1} in
		wifi|WIFI )
			assert_wifi_active_with_priority
			;;

		bt|BT )
			assert_bt_active_with_priority
			;;
		* )
			exit_coexistence
			return
			;;

	esac
	check_wifi_deny
	check_bt_deny
	exit_coexistence
