	eval "export isset=\${insmod_$1}"
	case "$isset" in
		1) ;;
		*) {
			[ "$2" ] && append INSMOD "$rmmod $1 >&- 2>&-" "$N"
			append INSMOD "$insmod $* >&- 2>&-" "$N"; export insmod_$1=1
		};;
	esac
