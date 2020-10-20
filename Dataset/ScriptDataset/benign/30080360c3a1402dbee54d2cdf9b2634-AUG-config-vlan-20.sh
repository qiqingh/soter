	# turn on ActiPHY feature (PHY_AUX_CTRL_STAT bit 6) for power saving
	for i in 0 1 2 3 4; do
		x=`expr $i \* 2 + 1`
		spicmd vtss write 3 0 1 4${x}c0000 /dev/null > /dev/null
		vreg=`spicmd vtss read 3 0 2 | sed -e 's/.*> //'`
		h1=`echo $vreg | sed -e 's/.//'`
		h2=`echo $vreg | sed -e 's/..//'`
		h3=`echo $vreg | sed -e 's/...//'`
		h4=`echo $vreg | sed -e 's/....//'`
		if [ "$h1" = "" ]; then
			spicmd vtss write 3 0 1 ${x}c004$vreg > /dev/null
		elif [ "$h2" = "" ]; then
			hex=`echo $vreg | sed -e 's/\(.\)./\1/'`
			post=`echo $vreg | sed -e 's/.\(.\)/\1/'`
			case $hex in
				"0")	rep="4";;
				"1")	rep="5";;
				"2")	rep="6";;
				"3")	rep="7";;
				"8")	rep="c";;
				"9")	rep="d";;
				"a")	rep="e";;
				"b")	rep="f";;
				*)	return;;
			esac
			spicmd vtss write 3 0 1 ${x}c00$rep$post > /dev/null
		elif [ "$h3" = "" ]; then
			pre=`echo $vreg | sed -e 's/\(.\)../\1/'`
			hex=`echo $vreg | sed -e 's/.\(.\)./\1/'`
			post=`echo $vreg | sed -e 's/..\(.\)/\1/'`
			case $hex in
				"0")	rep="4";;
				"1")	rep="5";;
				"2")	rep="6";;
				"3")	rep="7";;
				"8")	rep="c";;
				"9")	rep="d";;
				"a")	rep="e";;
				"b")	rep="f";;
				*)	return;;
			esac
			spicmd vtss write 3 0 1 ${x}c0$pre$rep$post > /dev/null
		elif [ "$h4" = "" ]; then
			pre=`echo $vreg | sed -e 's/\(..\)../\1/'`
			hex=`echo $vreg | sed -e 's/..\(.\)./\1/'`
			post=`echo $vreg | sed -e 's/...\(.\)/\1/'`
			case $hex in
				"0")	rep="4";;
				"1")	rep="5";;
				"2")	rep="6";;
				"3")	rep="7";;
				"8")	rep="c";;
				"9")	rep="d";;
				"a")	rep="e";;
				"b")	rep="f";;
				*)	return;;
			esac
			spicmd vtss write 3 0 1 ${x}c0$pre$rep$post > /dev/null
		fi
	done
