	[ $VERBOSE_MODE -le 1 ] && VERBOSE_MODE=2
	[ -f $LOGFILE ] && rm -f $LOGFILE
	write_log  7 "************ ************** ************** **************"
	write_log  5 "PID '$$' started at $(eval $DATE_PROG)"
	write_log  7 "ddns version  : $VERSION"
	write_log  7 "uci configuration:\n$(uci -q show ddns | grep '=service' | sort)"
	write_log 14 "Service section '$SECTION_ID' not defined"
