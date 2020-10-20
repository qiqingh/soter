	
	port=$1
	case $port in
		3)
			port_list="00010010"
			;;
		2)
			port_list="00100010"
			;;
		1)
			port_list="01000010"
			;;
		0)
			port_list="10000010"
			;;
	esac
