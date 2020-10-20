	ulog wlan status "${SERVICE_NAME}, loading Wi-Fi driver"
	echo "[utopia][init] Loading GMAC and WLAN drivers"
	/sbin/modprobe umac
	/sbin/modprobe shortcut-fe
	HW_ADDR=`syscfg get wl0_mac_addr`
	iwpriv wifi0 setHwaddr $HW_ADDR
	HW_ADDR=`syscfg get wl1_mac_addr`
	iwpriv wifi1 setHwaddr $HW_ADDR
	echo "[utopia][init] Creating wifi devices"
	/usr/sbin/wlanconfig ath0 create wlandev wifi0 wlanmode ap
	/usr/sbin/wlanconfig ath1 create wlandev wifi1 wlanmode ap
	/sbin/ifconfig ath0 txqueuelen 1000
	/sbin/ifconfig ath1 txqueuelen 1000
	/sbin/ifconfig wifi0 txqueuelen 1000
	/sbin/ifconfig wifi1 txqueuelen 1000
