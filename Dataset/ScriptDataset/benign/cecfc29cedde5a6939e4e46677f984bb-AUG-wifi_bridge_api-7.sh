	STA_VIR_IF=`syscfg_get wifi_sta_vir_if`
	HTBW=`iwpriv $STA_VIR_IF gethtbw | awk -F':' '{print $2}'`
	case "`echo $HTBW`" in
		"0")
		echo "auto"
		;;
		"2")
		echo "standard"
		;;
		"3")
		echo "wide"
		;;
		*)
		echo "error: unknown channel width"
	esac
	
