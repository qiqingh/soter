	RADIO=$1
	
	if [ -z "$RADIO" ]; then
		RADIO=`wds_guess_radio_from_channel $CHAN_STR`
	fi
	case "`echo $RADIO | tr [:upper:] [:lower:]`" in
		"2g")
		IDX=0
		;;
		"5g")
		IDX=1
		;;
		*)
		IDX=""
		;;
	esac
	if [ "0" != "$IDX" ] && [ "1" != "$IDX" ]; then
		print_help "Interface invalid"
	fi
	echo $IDX
