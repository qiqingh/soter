	local section="$1"
	local option="$2"
	local defaults="$3"
	local value=`uci get $PACKAGE.$section.$option`
	
	if [ -z "$value" ]; then
		for entry in $defaults; do
			uci add_list $PACKAGE.$section.$option="$entry"
		done
	else
		[ "$value" != "$defaults" ] && {
			uci delete $PACKAGE.$section.$option
			for entry in $defaults; do
				uci add_list $PACKAGE.$section.$option="$entry"
			done
		}
	fi
