	local ifname="$1"
	wmode=9
	VHT=0
	VHT_SGI=0
	HT=0
	EXTCHA=0
	start_apd=

	base_ifname="${ifname%0}"
	sta_ifname="apcli${ifname#ra}"

	json_select config
	json_get_vars variant country channel htmode log_level short_preamble noscan:0 macaddr
	json_select ..

	set_default short_preamble 1

	case "$hwmode" in
		a) wmode=8;;
		g) wmode=7;;
	esac

	case ${htmode:-none} in
	HT20)
		HT=0
		;;
	HT40)
		HT=1
		EXTCHA=1
		;;
	VHT20)
		wmode=15
		HT=0
		VHT=0
		VHT_SGI=1
		;;
	VHT40)
		wmode=15
		HT=1
		VHT=0
		VHT_SGI=1
		EXTCHA=1
		;;
	VHT80)
		wmode=15
		HT=1
		VHT=1
		VHT_SGI=1
		EXTCHA=1
		;;
	*)
		case $hwmode in
		a) wmode=2;;
		g) wmode=4;;
		esac
		;;
	esac

	if [ "$auto_channel" -gt 0 ]; then
		channel=0
		auto_channel=2
	else
		auto_channel=0
	fi

	coex=1
	[ "$noscan" -gt 0 ] && coex=0

	for_each_interface "ap" ralink_count_ap
	reload_module "${ap_count}"

	grep -vE '^(HT_BW|VHT_BW|HT_EXTCHA|VHT_SGI|BssidNum|TxPreamble|SSID|WirelessMode|HT_BSSCoexistence|Country|Channel|AutoChannel)' /etc/Wireless/${variant}_tpl.dat > /tmp/${variant}.dat
	cat >> /tmp/${variant}.dat<<EOF

BssidNum=${ap_count}
HT_BW=${HT:-0}
VHT_BW=${VHT:-0}
VHT_SGI=${VHT_SGI:-0}
HT_EXTCHA=${EXTCHA:-0}
CountryRegion=${regdom:-1}
CountryRegionForABand=${regdomA:-7}
CountryCode=${country}
WirelessMode=${wmode:-9}
Channel=${channel:-8}
AutoChannelSelect=$auto_channel
Debug=${log_level:-3}
SSID1=${ssid:-DD-WRT NXT}
TxPreamble=${short_preamble}
AutoChannelSkipList=52;56;60;64;100;104;108;112;116;120;124;128;132;136;140
HT_BSSCoexistence=$coex
WscConfMethods=680
${macaddr:+MacAddress=$macaddr}
EOF
	[ -f /lib/ramips.sh ] && {
		. /lib/ramips.sh
		board=$(ramips_board_name)
	}

	case $board in
		wsr-600)
			echo mt7603e.wsr600.sku > /tmp/SingleSKU.dat.mt7603
			;;
		wsr-1166)
			echo mt7603e.wsr1166.sku > /tmp/SingleSKU.dat.mt7603
			echo mt76x2.wsr1166.sku > /tmp/SingleSKU.dat.mt76x2
			;;
	esac
	
	ap_idx=0
	for_each_interface "ap" ralink_setup_ap
	for_each_interface "sta" ralink_setup_sta

	[ -n "$start_apd" ] && {
		rt2860apd -i "$start_apd" &
		sleep 1
		wireless_add_process "$!" `which rt2860apd` 1
	}

	wireless_set_up
