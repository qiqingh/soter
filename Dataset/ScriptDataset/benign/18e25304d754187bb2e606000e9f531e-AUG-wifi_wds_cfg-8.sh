	INPUT=$1
	if [ "1" = "$SECURITY_MODE" ] || [ "2" = "$SECURITY_MODE" ]; then
		if [ ! -n "$INPUT" ]; then 
			print_help "Should specify passphrase"
		fi
	fi
	echo $INPUT
