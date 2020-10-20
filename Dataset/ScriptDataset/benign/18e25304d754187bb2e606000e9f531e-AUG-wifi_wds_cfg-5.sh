	INPUT_MAC=$1
	MAC=`echo $INPUT_MAC | sed 's/[:]//g'`
	LEN_STR=`echo ${#MAC}`
	LEN=`expr $LEN_STR`
	if [ 12 -ne $LEN ]; then
		print_help "Peer MAC invalid"
	fi
	echo $MAC
