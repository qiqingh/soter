	local PACKAGE="$1"
	local TYPE="$2"
	local CONFIG="$3"

	if [ -z "$CONFIG" ]; then
		export ${NO_EXPORT:+-n} CONFIG_SECTION="$(/sbin/uci add "$PACKAGE" "$TYPE")"
	else
		/sbin/uci ${UCI_CONFIG_DIR:+-c $UCI_CONFIG_DIR} set "$PACKAGE.$CONFIG=$TYPE"
		export ${NO_EXPORT:+-n} CONFIG_SECTION="$CONFIG"
	fi
