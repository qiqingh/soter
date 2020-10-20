	local label
	local ledpath
	local basepath="/proc/device-tree"
	local nodepath="$basepath/aliases/led-$1"

	[ -f "$nodepath" ] && ledpath=$(cat "$nodepath")
	[ -n "$ledpath" ] && \
		label=$(cat "$basepath$ledpath/label" 2>/dev/null) || \
		label=$(cat "$basepath$ledpath/chan-name" 2>/dev/null)

	echo "$label"
