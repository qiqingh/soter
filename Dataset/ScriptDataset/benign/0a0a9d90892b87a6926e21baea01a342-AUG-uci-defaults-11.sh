	# inherited: $name $n_cpu $n_vlan $cpu0 $cpu1 $cpu2 $cpu3 $cpu4 $cpu5
	local index role roles num device need_tag want_untag port ports

	json_select switch
		json_select "$name"
			json_get_keys roles roles
		json_select ..
	json_select ..

	for index in $roles; do
		eval "port=\$cpu$(((index - 1) % n_cpu))"

		json_select switch
			json_select "$name"
				json_select ports
					json_select "$port"
						json_get_vars num device need_tag want_untag
					json_select ..
				json_select ..

				if [ ${need_tag:-0} -eq 1 -o ${want_untag:-0} -ne 1 ]; then
					num="${num}t"
					device="${device}.${index}"
				fi

				json_select roles
					json_select "$index"
						json_get_vars role ports
						json_add_string ports "$ports $num"
						json_add_string device "$device"
					json_select ..
				json_select ..
			json_select ..
		json_select ..

		json_select_object network
			local devices

			json_select_object "$role"
				# attach previous interfaces (for multi-switch devices)
				json_get_var devices ifname
				if ! list_contains devices "$device"; then
					devices="${devices:+$devices }$device"
				fi
			json_select ..

			_ucidef_set_interface "$role" "$devices"
		json_select ..
	done
