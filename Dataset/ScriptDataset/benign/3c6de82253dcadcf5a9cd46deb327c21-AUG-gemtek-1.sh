	local section="$1"
	local option="$2"
	local default="$3"

	uci get $PACKAGE.$section.$option >/dev/null 2>&1
	[ "$?" != 0 ] && uci set $PACKAGE.$section.$option="$default"
