	INPUT=$1
	if [ -z "$INPUT" ]; then
		INPUT="open"
	fi
	STATUS="unmatched"
	LIST="open wpa-personal wpa2-personal"
	for item in $LIST
	do
		if [ "$INPUT" = "$item" ]; then
			STATUS="matched"
			break
		fi
	done
	if [ "matched" != "$STATUS" ]; then
		print_help "Security is not defined"
	fi
	case $INPUT in
		"open")
			RET=0
			;;
		"wpa-personal")
			RET=1
			;;
		"wpa2-personal")
			RET=2
			;;
		*)
			RET=""
	esac
	if [ ! -z "$RET" ]; then
		echo $RET
	else
		print_help
	fi
