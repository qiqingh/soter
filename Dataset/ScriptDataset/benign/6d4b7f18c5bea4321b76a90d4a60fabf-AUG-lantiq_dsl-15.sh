	local ccsg
	local et
	local etr
	local d
	local h
	local m
	local s
	local rc=""

	ccsg=$(dsl_cmd pmccsg 0 0 0)
	et=$(dsl_val "$ccsg" nElapsedTime)

	[ -z "$et" ] && et=0

	d=$(expr $et / 86400)
	etr=$(expr $et % 86400)
	h=$(expr $etr / 3600)
	etr=$(expr $etr % 3600)
	m=$(expr $etr / 60)
	s=$(expr $etr % 60)


	[ "${d}${h}${m}${s}" -ne 0 ] && rc="${s}s"
	[ "${d}${h}${m}" -ne 0 ] && rc="${m}m ${rc}"
	[ "${d}${h}" -ne 0 ] && rc="${h}h ${rc}"
	[ "${d}" -ne 0 ] && rc="${d}d ${rc}"

	[ -z "$rc" ] && rc="down"


	if [ "$action" = "lucistat" ]; then
		echo "dsl.line_uptime=${et}"
		echo "dsl.line_uptime_s=\"${rc}\""
	else

		echo "Line Uptime Seconds:                      ${et}"
		echo "Line Uptime:                              ${rc}"
	fi
