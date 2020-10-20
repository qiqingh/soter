	RADIO=$1
	IF=""
	WLINDEX=""
	case "`echo $RADIO | tr [:upper:] [:lower:]`" in
		"2.4ghz")
		IF=wdev0
		STA_MODE=7
		WLINDEX="wl0"
		;;
		"5ghz")
		IF=wdev1
		STA_MODE=8
		WLINDEX="wl1"
		;;
		*)
		echo "Usage: wifi_bridge_api.sh get_wireless_networks <2.4GHz|5GHz>"
		exit
	esac
	STA_IF="$IF"sta0
	ifconfig $IF up
	iwpriv "$STA_IF" stamode "$STA_MODE"
	sleep 1
	iwconfig "$STA_IF" commit
	iwpriv "$STA_IF" stascan 1
	sleep 3
	iwpriv "$STA_IF" getstascan | grep "SSID=" | cut -d' ' -f 2- > /tmp/site_survey
	cat /tmp/site_survey | cut -c6-38 | sed -e "s/ \{1,\}$//" > /tmp/ss_ssids
	if [ "2.4GHz" = "$RADIO" ]; then
		cat /tmp/site_survey | cut -c39- | tr ' ' ';' | cut -d';' -f1,3,5 | awk '{print $0 ";2.4GHz"}' > /tmp/ss_data
	elif [ "5GHz" = "$RADIO" ]; then
		cat /tmp/site_survey | cut -c39- | tr ' ' ';' | cut -d';' -f1,3,5 | awk '{print $0 ";5GHz"}' > /tmp/ss_data
	fi
	sed -e s/";None;"/";disabled;"/ -e s/";WPA;"/";wpa-personal;"/ -e s/";WPA2;"/";wpa2-personal;"/ -e s/";WPA-WPA2;"/";wpa-mixed;"/ -i /tmp/ss_data
	awk '{getline var < "/tmp/ss_data"; print $0";" var}' /tmp/ss_ssids
	rm -f /tmp/ss_ssids
	rm -f /tmp/ss_data
	if [ "down" = `syscfg_get $WLINDEX"_state"` ]; then
		ifconfig $IF down
	fi
	exit
