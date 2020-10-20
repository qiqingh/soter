	zeros=$((32-$1))
	NETMASKNUM=0
	while [ $zeros != 0 ]; do
	        NETMASKNUM=$(( (NETMASKNUM << 1) ^ 1 ))
	        zeros=$(expr $zeros - 1)
	done
	NETMASKNUM=$((NETMASKNUM ^ 0xFFFFFFFF))

	b1=$(( ($NETMASKNUM & 0xFF000000) >> 24))
	b2=$(( ($NETMASKNUM & 0xFF0000) >> 16))
	b3=$(( ($NETMASKNUM & 0xFF00) >> 8))
	b4=$(( $NETMASKNUM & 0xFF ))
	eval "$2=\$b1.\$b2.\$b3.\$b4"
