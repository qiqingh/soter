	local name="$1"; shift
	local port num role device index need_tag prev_role
	local cpu0 cpu1 cpu2 cpu3 cpu4 cpu5
	local n_cpu=0 n_vlan=0 n_ports=0

	json_select_object switch
		json_select_object "$name"
			json_add_boolean enable 1
			json_add_boolean reset 1

			for port in "$@"; do
				case "$port" in
					[0-9]*@*)
						num="${port%%@*}"
						device="${port##*@}"
						need_tag=0
						want_untag=0
						[ "${num%t}" != "$num" ] && {
							num="${num%t}"
							need_tag=1
						}
						[ "${num%u}" != "$num" ] && {
							num="${num%u}"
							want_untag=1
						}
					;;
					[0-9]*:*:[0-9]*)
						num="${port%%:*}"
						index="${port##*:}"
						role="${port#[0-9]*:}"; role="${role%:*}"
					;;
					[0-9]*:*)
						num="${port%%:*}"
						role="${port##*:}"
					;;
				esac

				if [ -n "$num" ] && [ -n "$device$role" ]; then
					_ucidef_add_switch_port
				fi

				unset num device role index need_tag want_untag
			done
		json_select ..
	json_select ..

	_ucidef_finish_switch_roles
