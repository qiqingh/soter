	local pmsg=$(dsl_cmd g997pmsg)
	local pm=$(dsl_val "$pmsg" nPowerManagementStatus);
	local s;

	case "$pm" in
		"-1")		s="Power management state is not available" ;;
		"0")		s="L0 - Synchronized" ;;
		"1")		s="L1 - Power Down Data transmission (G.992.2)" ;;
		"2")		s="L2 - Power Down Data transmission (G.992.3 and G.992.4)" ;;
		"3")		s="L3 - No power" ;;
		*)		s="unknown" ;;
	esac

	if [ "$action" = "lucistat" ]; then
		echo "dsl.power_mode_num=${pm:-nil}"
		echo "dsl.power_mode_s=\"$s\""
	else
		echo "Power Management Mode:                    $s"
	fi
