	[ -n "$IPKG_INSTROOT" ] && return 0
	uci_load "$@"
