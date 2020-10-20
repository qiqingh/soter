	gn_enable=`nvram_get 2860 gn_enable`
	wl0_gmode=`nvram_get 2860 wl0_gmode`
	gn_lan_ifname=`nvram_get 2860 gn_lan_ifname`
	if [ "$gn_enable" = "1" -a "$wl0_gmode" != "-1" ]; then
		brctl addbr $gn_lan_ifname
		brctl setfd $gn_lan_ifname 1
		brctl stp $gn_lan_ifname 1
	fi
