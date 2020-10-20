	local PACKAGE="$1"
	local DATA
	local RET
	local VAR

	_C=0
	if [ -z "$CONFIG_APPEND" ]; then
		for VAR in $CONFIG_LIST_STATE; do
			export ${NO_EXPORT:+-n} CONFIG_${VAR}=
			export ${NO_EXPORT:+-n} CONFIG_${VAR}_LENGTH=
		done
		export ${NO_EXPORT:+-n} CONFIG_LIST_STATE=
		export ${NO_EXPORT:+-n} CONFIG_SECTIONS=
		export ${NO_EXPORT:+-n} CONFIG_NUM_SECTIONS=0
		export ${NO_EXPORT:+-n} CONFIG_SECTION=
	fi

	DATA="$(/sbin/uci ${UCI_CONFIG_DIR:+-c $UCI_CONFIG_DIR} ${LOAD_STATE:+-P /var/state} -S -n export "$PACKAGE" 2>/dev/null)"
	RET="$?"
	[ "$RET" != 0 -o -z "$DATA" ] || eval "$DATA"
	unset DATA

	${CONFIG_SECTION:+config_cb}
	return "$RET"
