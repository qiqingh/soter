	local PACKAGE="$1"
	local CONFIG="$2"
	local OPTION="$3"
	local VALUE="$4"

	[ "$#" = 4 ] || return 0
	/sbin/uci ${UCI_CONFIG_DIR:+-c $UCI_CONFIG_DIR} -P /var/state set "$PACKAGE.$CONFIG${OPTION:+.$OPTION}=$VALUE"
