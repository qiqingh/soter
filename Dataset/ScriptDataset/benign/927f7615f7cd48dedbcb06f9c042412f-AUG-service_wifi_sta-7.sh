	if [ "1" != "`syscfg_get wifi_bridge::mode`" ] || [ "started" != "`sysevent get lan-status`" ] ; then
		return
	fi
	PHY_IF=`syscfg_get lan_wl_physical_ifnames`
	STA_IF=`echo "wdev0 wdev1" | sed 's/'"${PHY_IF}"'//g' | sed 's/ //g'`
	STA_IF="$STA_IF"sta0
	ifconfig $STA_IF down
	LAN_IFNAME=`syscfg_get lan_ifname`
	brctl delif $LAN_IFNAME $STA_IF
	sysevent set wifi_sta_up 0
