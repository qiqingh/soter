	local csg

	local idu
	local idu_s;
	local sidu

	local idd
	local idd_s;
	local sidd

	csg=$(dsl_cmd g997csg 0 1)
	idd=$(dsl_val "$csg" ActualInterleaveDelay)

	csg=$(dsl_cmd g997csg 0 0)
	idu=$(dsl_val "$csg" ActualInterleaveDelay)

	[ -z "$idd" ] && idd=0
	[ -z "$idu" ] && idu=0

	if [ "$idd" -gt 100 ]; then
		idd_s="Interleave"
	else
		idd_s="Fast"
	fi

	if [ "$idu" -gt 100 ]; then
		idu_s="Interleave"
	else
		idu_s="Fast"
	fi

	sidu=$(scale_latency $idu)
	sidd=$(scale_latency $idd)

	if [ "$action" = "lucistat" ]; then
		echo "dsl.latency_down=\"$(scale_latency_us $idd)\""
		echo "dsl.latency_up=\"$(scale_latency_us $idu)\""
		echo "dsl.latency_num_down=\"$sidd\""
		echo "dsl.latency_num_up=\"$sidu\""
		echo "dsl.latency_s_down=\"$idd_s\""
		echo "dsl.latency_s_up=\"$idu_s\""
	else
		echo "Latency [Interleave Delay]:               ${sidd} [${idd_s}]   ${sidu} [${idu_s}]"
	fi
