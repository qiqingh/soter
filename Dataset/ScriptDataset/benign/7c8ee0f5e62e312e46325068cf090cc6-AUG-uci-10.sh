	local PACKAGE="$1"
	local CONFIG="$2"
	local VALUE="$3"

	/sbin/uci ${UCI_CONFIG_DIR:+-c $UCI_CONFIG_DIR} rename "$PACKAGE.$CONFIG=$VALUE"
