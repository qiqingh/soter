	IFNAME=$1
	STAMODE=6
	case "`echo $IFNAME | cut -c 5`" in
		"0")
		STAMODE=7
		;;
		"1")
		STAMODE=8
		;;
	esac
	echo $STAMODE
