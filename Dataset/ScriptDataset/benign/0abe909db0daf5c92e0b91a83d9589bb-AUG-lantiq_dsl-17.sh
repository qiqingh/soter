	local lsg
	local latnu
	local latnd
	local satnu
	local satnd
	local snru
	local snrd
	local attndru
	local attndrd
	local sattndru
	local sattndrd
	local actatpu
	local actatpd

	lsg=$(dsl_cmd g997lsg 1 1)
	latnd=$(dsl_val "$lsg" LATN)
	satnd=$(dsl_val "$lsg" SATN)
	snrd=$(dsl_val "$lsg" SNR)
	attndrd=$(dsl_val "$lsg" ATTNDR)
	actatpd=$(dsl_val "$lsg" ACTATP)

	lsg=$(dsl_cmd g997lsg 0 1)
	latnu=$(dsl_val "$lsg" LATN)
	satnu=$(dsl_val "$lsg" SATN)
	snru=$(dsl_val "$lsg" SNR)
	attndru=$(dsl_val "$lsg" ATTNDR)
	actatpu=$(dsl_val "$lsg" ACTATP)

	[ -z "$latnd" ] && latnd=0
	[ -z "$latnu" ] && latnu=0
	[ -z "$satnd" ] && satnd=0
	[ -z "$satnu" ] && satnu=0
	[ -z "$snrd" ] && snrd=0
	[ -z "$snru" ] && snru=0
	[ -z "$actatpd" ] && actatpd=0
	[ -z "$actatpu" ] && actatpu=0

	latnd=$(dbt $latnd)
	latnu=$(dbt $latnu)
	satnd=$(dbt $satnd)
	satnu=$(dbt $satnu)
	snrd=$(dbt $snrd)
	snru=$(dbt $snru)
	actatpd=$(dbt $actatpd)
	actatpu=$(dbt $actatpu)

	[ -z "$attndrd" ] && attndrd=0
	[ -z "$attndru" ] && attndru=0

	sattndrd=$(scale $attndrd)
	sattndru=$(scale $attndru)
	
	if [ "$action" = "lucistat" ]; then
		echo "dsl.line_attenuation_down=\"$latnd\""
		echo "dsl.line_attenuation_up=\"$latnu\""
		echo "dsl.noise_margin_down=\"$snrd\""
		echo "dsl.noise_margin_up=\"$snru\""
		echo "dsl.signal_attenuation_down=\"$satnd\""
		echo "dsl.signal_attenuation_up=\"$satnu\""
		echo "dsl.actatp_down=\"$actatpd\""
		echo "dsl.actatp_up=\"$actatpu\""
		echo "dsl.max_data_rate_down=$attndrd"
		echo "dsl.max_data_rate_up=$attndru"
		echo "dsl.max_data_rate_down_s=\"$sattndrd\""
		echo "dsl.max_data_rate_up_s=\"$sattndru\""
	else
		echo "Line Attenuation (LATN):                  Down: ${latnd} dB / Up: ${latnu} dB"
		echo "Signal Attenuation (SATN):                Down: ${satnd} dB / Up: ${satnu} dB"
		echo "Noise Margin (SNR):                       Down: ${snrd} dB / Up: ${snru} dB"
		echo "Aggregate Transmit Power (ACTATP):        Down: ${actatpd} dB / Up: ${actatpu} dB"
		echo "Max. Attainable Data Rate (ATTNDR):       Down: ${sattndrd}/s / Up: ${sattndru}/s"
	fi
