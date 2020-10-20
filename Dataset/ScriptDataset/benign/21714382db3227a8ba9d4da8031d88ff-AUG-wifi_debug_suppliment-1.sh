	VIR_IFNAME=$1
	
	if [ "${VIR_IFNAME}" = "ra0" ]; then
		SSID=`syscfg_get wl0_ssid`
	elif [ "${VIR_IFNAME}" = "ra1" ]; then
		SSID=`syscfg_get guest_ssid`
	elif [ "${VIR_IFNAME}" = "rai0" ]; then
		SSID=`syscfg_get wl1_ssid`
	fi
	
	echo "------------- ${VIR_IFNAME} Settings -------------"
	echo "Interface name: $VIR_IFNAME"
	echo "SSID: $SSID"
	echo "Mac address: `iwconfig ${VIR_IFNAME} | grep "Access Point" | cut -d':' -f3-8`"
	echo "Channel: `iwlist ${VIR_IFNAME} channel`"
	echo "Banwidth (0=auto,2=20HMz,3=40MHz): `iwpriv ${VIR_IFNAME} gethtbw`"
	echo "Network Mode (1:b, 2:g, 3:b/g, 4:n[2.4GHz], 6:g/n, 7:b/g/n, 8:a, 12:a/n, 13:n[5GHz], 23:b/g/n/ac, 28:a/n/ac): `iwpriv ${VIR_IFNAME} getopmode`"
	echo "Guard Interval (0=auto,1=Short,2=Long): Current `iwpriv ${VIR_IFNAME} getguardint`"
	echo "Current connected client(s): `iwpriv ${VIR_IFNAME} getstalistext`"
	echo "Tx Antennas (0=auto i.e all antennas, 1=antenna A, 2=antenna B, 3=antenna AB, 7=antenna ABC, 0xF= antenna ABCD): `iwpriv ${VIR_IFNAME} gettxantenna`"
	echo "Rx Antennas (0=auto,1=1 antenna, 2=2 antennas, 3=3 antennas, 4=4 antennas): `iwpriv ${VIR_IFNAME} getrxantenna`"
	echo "WMM mode (0=AC_BE, 1=AC_BK, 2=AC_VI, 3=AC_VO): `iwpriv ${VIR_IFNAME} getwmm`"
	echo "Optimization Level (0=harmony mode, 1=high performance): `iwpriv ${VIR_IFNAME} getoptlevel`"
	echo "Multicast Proxy (0=disable, 1=enable ): `iwpriv ${VIR_IFNAME} getmcastproxy`"
	echo "Intra BSS bridging (0=disable wireless to wireless client bridging, 1=enable wireless to wireless client bridging): `iwpriv ${VIR_IFNAME} getintrabss`"
	echo "SSID broacast (0=show and respond to probe requests, 1=hide and do not respond to probe requests) `iwpriv ${VIR_IFNAME} gethidessid`"
	echo "Beacon interval (20-1000: interval in time units 1=1.024ms): `iwpriv ${VIR_IFNAME} getbcninterval`"
	echo "Power save DTIM (1-255): `iwpriv ${VIR_IFNAME} getdtim`"
	echo "11g protection (0=protection off, 1=protection auto): `iwpriv ${VIR_IFNAME} getgprotect`"
	echo "Preamble (0=auto, 1=short preamble, 2=long preamble): `iwpriv ${VIR_IFNAME} getpreamble`"
	echo "Idle aging time (60-86400 sec): `iwpriv ${VIR_IFNAME} getagingtime`"
	echo "Associations to AP BSS (0=disable, 1=enable ): `iwpriv ${VIR_IFNAME} getdisableassoc`"
	echo "WDS mode (0=disable, 1=enable ): `iwpriv ${VIR_IFNAME} getwdsmode`"
	echo "HT Greenfield mode (0=disable, 1=enable ): `iwpriv ${VIR_IFNAME} gethtgf`"
	echo "Tx Power: `iwpriv ${VIR_IFNAME} gettxpower`"
	echo ""
