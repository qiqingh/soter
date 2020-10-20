	local bpstg=$(dsl_cmd bpstg)
	local profile=$(dsl_val "$bpstg" nProfile);
	local s;

	case "$profile" in
		"0")	s="8a" ;;
		"1")	s="8b" ;;
		"2")	s="8c" ;;
		"3")	s="8d" ;;
		"4")	s="12a" ;;
		"5")	s="12b" ;;
		"6")	s="17a" ;;
		"7")	s="30a" ;;
		"8")	s="17b" ;;
		"")		s="";;
		*)		s="unknown" ;;
	esac

	if [ "$action" = "lucistat" ]; then
		echo "dsl.profile=${profile:-nil}"
		echo "dsl.profile_s=\"${s}\""
	else
		echo "Profile:                                  $s"
	fi
