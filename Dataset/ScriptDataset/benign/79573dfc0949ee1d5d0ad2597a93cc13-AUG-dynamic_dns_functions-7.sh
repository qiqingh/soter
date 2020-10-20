	local __STR __LEN __CHAR __OUT
	local __ENC=""
	local __POS=1
	[ $# -ne 2 ] && write_log 12 "Error calling 'urlencode()' - wrong number of parameters"
	__STR="$2"
	__LEN=${#__STR}
	while [ $__POS -le $__LEN ]; do
		__CHAR=$(expr substr "$__STR" $__POS 1)
		case "$__CHAR" in
		        [-_.~a-zA-Z0-9] )
				__OUT="${__CHAR}"
				;;
		        * )
		               __OUT=$(printf '%%%02x' "'$__CHAR" )
				;;
		esac
		__ENC="${__ENC}${__OUT}"
		__POS=$(( $__POS + 1 ))
	done
	eval "$1=\"$__ENC\""
	return 0
