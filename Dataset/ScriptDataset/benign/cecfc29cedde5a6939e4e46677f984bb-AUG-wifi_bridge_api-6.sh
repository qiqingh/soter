	STA_VIR_IF=`syscfg_get wifi_sta_vir_if`
	OPMODE=`iwpriv $STA_VIR_IF getopmode | awk -F':' '{print $2}'`
	case "`echo $OPMODE`" in
		"1")
		echo "11b"
		;;
		"2")
		echo "11g"
		;;
		"3")
		echo "11b 11g"
		;;
		"4")
		echo "11n"
		;;
		"6")
		echo "11g 11n"
		;;
		"7")
		echo "11b 11g 11n"
		;;
		"8")
		echo "11a"
		;;
		"12")
		echo "11a 11n"
		;;
		"13")
		echo "11n"
		;;
		"23")
		echo "11b 11g 11n 11ac"
		;;
		"28")
		echo "11a 11n 11ac"
		;;
		*)
		echo "error: unknown network mode"
	esac
