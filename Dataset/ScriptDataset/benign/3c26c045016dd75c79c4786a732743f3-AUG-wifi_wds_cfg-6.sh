	INPUT=$1
	if [ -z "$INPUT" ]; then
		INPUT=ac3
	fi
	STATUS="unmatched"
	LIST="b g n a ac3"
	for item in $LIST
	do
		if [ "$INPUT" = "$item" ]; then
			STATUS="matched"
			break
		fi
	done
	if [ "matched" = "$STATUS" ]; then
		echo $INPUT
	else
		print_help "Network mode invalid"
	fi
