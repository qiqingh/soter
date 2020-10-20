	if [ "1" = "`sysevent get NVRAM_DIRTY`" ] ; then
		nvram commit
		sysevent set NVRAM_DIRTY "0"
	fi
