	vreg=`spicmd vtss read 7 0 10 | sed -e 's/.*> //'`
	pre=`echo $vreg | sed -e 's/\(.*\)[0-9a-f]/\1/'`
	hex=`echo $vreg | sed -e 's/.*\([0-9a-f]\)/\1/'`

	# 0 -> disable clock (bit 1)
	# 1 -> enable clock (bit 1)
		# 2 -> soft reset (bit 0)
	if [ "$1" = "0" ]; then
			case $hex in
				"2")	rep="0"	;;
				"3")	rep="1"	;;
				"6")	rep="4"	;;
				"7")	rep="5"	;;
			"a")	rep="8"	;;
			"b")	rep="9"	;;
			"e")	rep="c"	;;
			"f")	rep="d"	;;
			*)	return;;
		esac
		new=$pre$rep
		spicmd vtss write 7 0 10 $new > /dev/null
	elif [ "$1" = "1" ]; then
		case $hex in
			"0")	rep="2"	;;
			"1")	rep="3"	;;
			"4")	rep="6"	;;
			"5")	rep="7"	;;
			"8")	rep="a"	;;
			"9")	rep="b"	;;
			"c")	rep="e"	;;
			"d")	rep="f"	;;
			*)	return;;
		esac
		new=$pre$rep
		spicmd vtss write 7 0 10 $new > /dev/null
	elif [ "$1" = "2" ]; then
		case $hex in
			"1")	rep="0";;
			"3")	rep="2";;
			"5")	rep="4";;
			"7")	rep="6";;
			"9")	rep="8";;
			"b")	rep="a";;
			"d")	rep="c";;
			"f")	rep="e";;
			*)	return;;
		esac
		new=$pre$rep
		spicmd vtss write 7 0 10 $new > /dev/null
		spicmd vtss write 7 0 10 $vreg > /dev/null
	fi
