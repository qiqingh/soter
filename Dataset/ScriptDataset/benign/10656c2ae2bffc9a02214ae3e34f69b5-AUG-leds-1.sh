	local ledpath
	local basepath="/proc/device-tree"
	local nodepath="$basepath/aliases/led-$1"

	[ -f "$nodepath" ] && ledpath=$(cat "$nodepath")
	[ -n "$ledpath" ] && ledpath="$basepath$ledpath"

	echo "$ledpath"
