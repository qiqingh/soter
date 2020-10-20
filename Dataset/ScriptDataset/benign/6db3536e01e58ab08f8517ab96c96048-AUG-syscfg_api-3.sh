	if [ "1" = "`sysevent get SYSCFG_DIRTY`" ]; then
		syscfg commit
		sysevent set SYSCFG_DIRTY "0"
	fi
