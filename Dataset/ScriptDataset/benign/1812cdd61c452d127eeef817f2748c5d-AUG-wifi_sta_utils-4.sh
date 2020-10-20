	RADIO=$1
	IF=""
	case "`echo "$RADIO" | tr [:upper:] [:lower:]`" in
		"2.4ghz")
		IF=wdev0
		STA_MODE=7
		;;
		"5ghz")
		IF=wdev1
		STA_MODE=8
		;;
		*)
		echo "site survey error: invalid radio"
	esac
	STA_IF="$IF"sta0
	ifconfig "$STA_IF" up
	iwpriv "$STA_IF" stamode "$STA_MODE"
	sleep 1
	iwconfig "$STA_IF" commit
	iwpriv "$STA_IF" stascan 1
	sleep 5
	iwpriv "$STA_IF" getstascan
