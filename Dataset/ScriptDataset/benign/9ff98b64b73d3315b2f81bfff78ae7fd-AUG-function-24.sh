	ifRaxWdsxDown
	ifRaixWdsxDown
	ifRaexWdsxDown
	if [ "$CONFIG_RT2860V2_AP" != "" ]; then
		rmmod rt2860v2_ap_net
		rmmod rt2860v2_ap
		rmmod rt2860v2_ap_util
	fi
	if [ "$CONFIG_RT2860V2_STA" != "" ]; then
		rmmod rt2860v2_sta_net
		rmmod rt2860v2_sta
		rmmod rt2860v2_sta_util
	fi
	if [ "$RT2880v2_INIC_PCI" != "" ]; then
		rmmod iNIC_pci
	fi

	if [ "$CONFIG_RLT_AP_SUPPORT" != "" -o "$CONFIG_RLT_STA_SUPPORT" != "" ]; then
	  rmmod rlt_wifi 
		
	fi
	if [ "$CONFIG_MT_AP_SUPPORT" != "" ]; then
			rmmod mt_wifi
	fi
	if [ "$CONFIG_RT3090_AP" != "" ]; then
		rmmod RT3090_ap_net
		rmmod RT3090_ap
		rmmod RT3090_ap_util
	fi
	if [ "$CONFIG_RT5392_AP" != "" ]; then
		rmmod RT5392_ap
	fi
	if [ "$CONFIG_RT5592_AP" != "" ]; then
		rmmod RT5592_ap
	fi
	if [ "$CONFIG_RT3593_AP" != "" ]; then
		rmmod RT3593_ap
	fi
	if [ "$CONFIG_MT7610_AP" != "" ]; then
		rmmod MT7610_ap
	fi
	if [ "$CONFIG_RTPCI_AP" != "" ]; then
		rmmod RTPCI_ap
	fi
	if [ "$CONFIG_RT3572_AP" != "" ]; then
		rmmod RT3572_ap_net
		rmmod RT3572_ap
		rmmod RT3572_ap_util
	fi
	if [ "$CONFIG_RT5572_AP" != "" ]; then
		rmmod RT5572_ap_net
		rmmod RT5572_ap
		rmmod RT5572_ap_util
	fi
	if [ "$RT305x_INIC_USB" != "" ]; then
		rmmod iNIC_usb
	fi
	if [ "$CONFIG_RT3680_iNIC_AP" != "" ]; then
		rmmod RT3680_ap
	fi
	if [ "$CONFIG_RT2561_AP" != "" ]; then
		rmmod rt2561ap
	fi

