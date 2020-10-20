	name="$1"; shift
	cmd="$1"; shift

	case "$cmd" in
		dump)
			add_driver() {
				eval "drv_$1_cleanup"

				json_init
				json_add_string name "$1"

				json_add_array device
				_wdev_common_device_config
				eval "drv_$1_init_device_config"
				json_close_array

				json_add_array iface
				_wdev_common_iface_config
				eval "drv_$1_init_iface_config"
				json_close_array

				json_add_array vlan
				_wdev_common_vlan_config
				eval "drv_$1_init_vlan_config"
				json_close_array

				json_add_array station
				_wdev_common_station_config
				eval "drv_$1_init_station_config"
				json_close_array

				json_dump
			}
		;;
		setup|teardown)
			interface="$1"; shift
			data="$1"; shift
			export __netifd_device="$interface"

			add_driver() {
				[[ "$name" == "$1" ]] || return 0
				_wdev_handler "$1" "$cmd"
			}
		;;
	esac
