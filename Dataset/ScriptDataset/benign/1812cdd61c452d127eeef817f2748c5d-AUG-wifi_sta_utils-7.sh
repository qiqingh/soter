	IF=$1
	CHANNEL=`syscfg get wifi_sta_channel`
	ifconfig $IF up
	iwpriv "$IF" autochannel 1
	if [ -n "$CHANNEL" ]; then
		iwpriv "$IF" autochannel 1
		iwconfig "$IF" channel "$CHANNEL"
	else
		iwpriv "$IF" autochannel 1
	fi
	iwpriv "$IF" wmm 1
	iwpriv "$IF" htbw 0
	sleep 1
	iwconfig $IF commit
