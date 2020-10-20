	PHY_IF=$1
	if [ "1" = "`syscfg get wl0_256qam_enabled`" ] ; then
		echo "${SERVICE_NAME}, set VHT mode on 2.4 g radio"
		wl -i $PHY_IF ampdu_mpdu 64
		wl -i $PHY_IF mpc 1
		wl -i $PHY_IF ack_ratio 4
	else
		wl -i $PHY_IF ampdu_mpdu -1
		wl -i $PHY_IF mpc 0
		wl -i $PHY_IF ack_ratio 2
	fi
