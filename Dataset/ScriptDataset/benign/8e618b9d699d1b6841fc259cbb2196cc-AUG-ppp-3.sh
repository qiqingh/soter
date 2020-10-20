	local errorcode=$1
	[ -n "$errorcode" ] || errorcode=5

	case "$errorcode" in
		0) echo "OK" ;;
		1) echo "FATAL_ERROR" ;;
		2) echo "OPTION_ERROR" ;;
		3) echo "NOT_ROOT" ;;
		4) echo "NO_KERNEL_SUPPORT" ;;
		5) echo "USER_REQUEST" ;;
		6) echo "LOCK_FAILED" ;;
		7) echo "OPEN_FAILED" ;;
		8) echo "CONNECT_FAILED" ;;
		9) echo "PTYCMD_FAILED" ;;
		10) echo "NEGOTIATION_FAILED" ;;
		11) echo "PEER_AUTH_FAILED" ;;
		12) echo "IDLE_TIMEOUT" ;;
		13) echo "CONNECT_TIME" ;;
		14) echo "CALLBACK" ;;
		15) echo "PEER_DEAD" ;;
		16) echo "HANGUP" ;;
		17) echo "LOOPBACK" ;;
		18) echo "INIT_FAILED" ;;
		19) echo "AUTH_TOPEER_FAILED" ;;
		20) echo "TRAFFIC_LIMIT" ;;
		21) echo "CNID_AUTH_FAILED";;
		*) echo "UNKNOWN_ERROR" ;;
	esac
