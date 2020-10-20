	INPUT_CHANNEL=$1
	STATUS="unmatched"
	LIST="1 2 3 4 5 6 7 8 9 10 11 36 40 44 48 149 153 157 161"
	for item in $LIST
	do
		if [ "$INPUT_CHANNEL" = "$item" ]; then
			STATUS="matched"
			break
		fi
	done
	if [ "matched" = "$STATUS" ]; then
		echo $INPUT_CHANNEL
	else
		print_help "Channel invalid"
	fi
