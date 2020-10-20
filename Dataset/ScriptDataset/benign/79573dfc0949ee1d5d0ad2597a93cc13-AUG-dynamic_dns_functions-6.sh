	local __LEVEL __EXIT __CMD __MSG
	local __TIME=$(date +%H%M%S)
	[ $1 -ge 10 ] && {
		__LEVEL=$(($1-10))
		__EXIT=1
	} || {
		__LEVEL=$1
		__EXIT=0
	}
	shift
	[ $__EXIT -eq 0 ] && __MSG="$*" || __MSG="$* - TERMINATE"
	case $__LEVEL in
		0)	__CMD="logger -p user.emerg -t ddns-scripts[$$] $SECTION_ID: $__MSG"
			__MSG=" $__TIME EMERG : $__MSG" ;;
		1)	__CMD="logger -p user.alert -t ddns-scripts[$$] $SECTION_ID: $__MSG"
			__MSG=" $__TIME ALERT : $__MSG" ;;
		2)	__CMD="logger -p user.crit -t ddns-scripts[$$] $SECTION_ID: $__MSG"
			__MSG=" $__TIME  CRIT : $__MSG" ;;
		3)	__CMD="logger -p user.err -t ddns-scripts[$$] $SECTION_ID: $__MSG"
			__MSG=" $__TIME ERROR : $__MSG" ;;
		4)	__CMD="logger -p user.warn -t ddns-scripts[$$] $SECTION_ID: $__MSG"
			__MSG=" $__TIME  WARN : $__MSG" ;;
		5)	__CMD="logger -p user.notice -t ddns-scripts[$$] $SECTION_ID: $__MSG"
			__MSG=" $__TIME  note : $__MSG" ;;
		6)	__CMD="logger -p user.info -t ddns-scripts[$$] $SECTION_ID: $__MSG"
			__MSG=" $__TIME  info : $__MSG" ;;
		7)	__MSG=" $__TIME       : $__MSG";;
		*) 	return;;
	esac
	[ $VERBOSE_MODE -gt 0 -o $__EXIT -gt 0 ] && echo -e "$__MSG"
	if [ ${use_logfile:-1} -eq 1 -o $VERBOSE_MODE -gt 1 ]; then
		echo -e "$__MSG" >> $LOGFILE
		[ $VERBOSE_MODE -gt 1 ] || sed -i -e :a -e '$q;N;'$LOGLINES',$D;ba' $LOGFILE
	fi
	[ $LUCI_HELPER ]   && return
	[ $__LEVEL -eq 7 ] && return
	__CMD=$(echo -e "$__CMD" | tr -d '\n' | tr '\t' '     ')
	[ $__EXIT  -eq 1 ] && {
		$__CMD
		exit 1
	}
	[ $use_syslog -eq 0 ] && return
	[ $((use_syslog + __LEVEL)) -le 7 ] && $__CMD
	return
