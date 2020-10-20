	local PACKAGE="$1"
	/sbin/uci ${UCI_CONFIG_DIR:+-c $UCI_CONFIG_DIR} commit $PACKAGE
