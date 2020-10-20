	local PACKAGE="$1"
	local CONFIG="$2"
	local OPTION="$3"
	local DEFAULT="$4"
	local STATE="$5"

	/sbin/uci ${UCI_CONFIG_DIR:+-c $UCI_CONFIG_DIR} ${STATE:+-P $STATE} -q get "$PACKAGE${CONFIG:+.$CONFIG}${OPTION:+.$OPTION}"
	RET="$?"
	[ "$RET" -ne 0 ] && [ -n "$DEFAULT" ] && echo "$DEFAULT"
	return "$RET"