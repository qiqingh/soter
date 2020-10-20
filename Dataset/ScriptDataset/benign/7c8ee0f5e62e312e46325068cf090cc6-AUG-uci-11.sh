	local PACKAGE="$1"
	local CONFIG="$2"
	local OPTION="$3"

	/sbin/uci ${UCI_CONFIG_DIR:+-c $UCI_CONFIG_DIR} del "$PACKAGE.$CONFIG${OPTION:+.$OPTION}"
