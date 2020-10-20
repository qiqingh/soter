	INPUT=$1
	CHAN_2GHZ="1 2 3 4 5 6 7 8 9 10 11"
	CHAN_5GHZ="36 40 44 48 149 153 157 161"
	STATUS="unmatched"
	for item in $CHAN_2GHZ
	do
		if [ "$INPUT" = "$item" ]; then
			STATUS="matched"
			OUTPUT="2g"
			break
		fi
	done
	if [ "unmatched" = "$STATUS" ]; then
		for item in $CHAN_5GHZ
		do
			if [ "$INPUT" = "$item" ]; then
				STATUS="matched"
				OUTPUT="5g"
				break
			fi
		done
	fi
	if [ "matched" = "$STATUS" ]; then
		echo $OUTPUT
	else
		print_help "Channel invalid"
	fi
