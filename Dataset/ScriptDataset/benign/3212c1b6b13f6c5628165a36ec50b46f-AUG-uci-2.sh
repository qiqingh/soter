	local PACKAGE="$1"
	/sbin/uci ${UCI_CONFIG_DIR:+-c $UCI_CONFIG_DIR} -q show "$PACKAGE" > /dev/null && return 0
	/sbin/uci ${UCI_CONFIG_DIR:+-c $UCI_CONFIG_DIR} import "$PACKAGE"
	/sbin/uci ${UCI_CONFIG_DIR:+-c $UCI_CONFIG_DIR} commit "$PACKAGE"
