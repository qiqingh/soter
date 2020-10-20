	RADIO=$1
	IFNAME=""
	INDEX=""
	case "`echo $RADIO | tr [:upper:] [:lower:]`" in
		"2g")
		INDEX=0
		;;
		"5g")
		INDEX=1
		;;
	esac
	
	IFNAME=`syscfg get wl"$INDEX"_physical_ifname`
	echo "$IFNAME"
