	[ $# -ne 4 ] && write_log 12 "Error calling 'split_FQDN()' - wrong number of parameters"
	[ -z "$1"  ] && write_log 12 "Error calling 'split_FQDN()' - missing FQDN to split"
	[ -f $TLDFILE ] || write_log 12 "Error calling 'split_FQDN()' - missing file '$TLDFILE'"
	local _HOST _FDOM _CTLD _FTLD
	local _SET="$@"
	local _PAR=$(echo "$1" | tr [A-Z] [a-z] | tr "." " ")
	set -- $_PAR
	_PAR=""
	while [ -n "$1" ] ; do
		_PAR="$1 $_PAR"
		shift
	done
	set -- $_PAR
	_PAR=""
	while [ -n "$1" ] ; do
		if [ -z "$_CTLD" ]; then
			_CTLD="$1"
			shift
		else
			_CTLD="$1.$_CTLD"
			shift
		fi
		zcat $TLDFILE | grep -E "^$_CTLD$" >/dev/null 2>&1 && {
			_FTLD="$_CTLD"
			_FDOM="$1"
			continue
		}
		zcat $TLDFILE | grep -E "^\*.$_CTLD$" >/dev/null 2>&1 && {
			[ -z "$1" ] && break
			if zcat $TLDFILE | grep -E "^!$1.$_CTLD$" >/dev/null 2>&1 ; then
				_FTLD="$_CTLD"
			else
				_FTLD="$1.$_CTLD"
				shift
			fi
			_FDOM="$1"; shift
		}
		[ -n "$_FTLD" ] && break
	done
	while [ -n "$1" ]; do
		_HOST="$1 $_HOST"
		shift
	done
	_HOST=$(echo $_HOST | tr " " ".")
	set -- $_SET
	[ -n "$_FTLD" ] && {
		eval "$2=$_FTLD"
		eval "$3=$_FDOM"
		eval "$4=$_HOST"
		return 0
	}
	eval "$2=''"
	eval "$3=''"
	eval "$4=''"
	return 1
