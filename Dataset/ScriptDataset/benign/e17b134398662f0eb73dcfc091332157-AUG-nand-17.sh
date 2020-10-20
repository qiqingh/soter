	[ -f /tmp/sysupgrade-nand-path ] && {
		path="$(cat /tmp/sysupgrade-nand-path)"
		[ "$SAVE_CONFIG" != 1 -a -f "$CONF_TAR" ] &&
			rm $CONF_TAR

		ubus call system nandupgrade "{\"path\": \"$path\" }"
		exit 0
	}
