	local csg
	local dru
	local drd
	local sdru
	local sdrd

	csg=$(dsl_cmd g997csg 0 1)
	drd=$(dsl_val "$csg" ActualDataRate)

	csg=$(dsl_cmd g997csg 0 0)
	dru=$(dsl_val "$csg" ActualDataRate)

	[ -z "$drd" ] && drd=0
	[ -z "$dru" ] && dru=0

	sdrd=$(scale $drd)
	sdru=$(scale $dru)

	if [ "$action" = "lucistat" ]; then
		echo "dsl.data_rate_down=$drd"
		echo "dsl.data_rate_up=$dru"
		echo "dsl.data_rate_down_s=\"$sdrd\""
		echo "dsl.data_rate_up_s=\"$sdru\""
	else
		echo "Data Rate:                                Down: ${sdrd}/s / Up: ${sdru}/s"
	fi
