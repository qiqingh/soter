	IF_PHY=wdev"$IF_PHY_IDX"
	IF_VAP=wdev"$IF_PHY_IDX"ap"$IF_VAP_IDX"
	IF_WDS=wdev"$IF_PHY_IDX"ap"$IF_VAP_IDX"wds"$IF_WDS_IDX"
	iwpriv $IF_PHY autochannel 0
	iwconfig $IF_PHY channel "$CHAN_NUM"
	sleep 1
	iwconfig $IF_PHY commit
	case "$SECURITY_MODE" in
		0)
			iwpriv $IF_VAP wpawpa2mode 0
			;;
		1)
			iwpriv $IF_VAP wpawpa2mode 1
            iwpriv $IF_VAP ciphersuite "wpa tkip"
			iwpriv $IF_VAP passphrase "wpa $PASSPHRASE"
			;;
		2)
			iwpriv $IF_VAP wpawpa2mode 2
            iwpriv $IF_VAP ciphersuite "wpa2 aes-ccmp"
			iwpriv $IF_VAP passphrase "wpa2 $PASSPHRASE"
			;;
	esac
	iwpriv $IF_VAP wdsmode 1
	iwpriv $IF_VAP setwds "$PORT $PEER_MAC $NETWORK_MODE"
	sleep 1
	iwconfig $IF_VAP commit
	ifconfig $IF_WDS up
	brctl addif "$BRIDGE_NAME" $IF_WDS
