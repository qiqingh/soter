	RADIO=$1
	IF=""
	WLINDEX=""
	case "`echo $RADIO | tr [:upper:] [:lower:]`" in
		"2.4ghz")
		IF=`syscfg get wl0_physical_ifname`
		STA_MODE=7
		WLINDEX="wl0"
	    STA_IF="apcli0"
		;;
		"5ghz")
		IF=`syscfg get wl1_physical_ifname`
		STA_MODE=8
		WLINDEX="wl1"
	    STA_IF="apclii0"
		;;
		*)
		echo "Usage: wifi_bridge_api.sh get_wireless_networks <2.4GHz|5GHz>"
		exit
	esac
	ifconfig $IF up
	ifconfig "$STA_IF" up
	iwpriv "$STA_IF" set SiteSurvey=1
	sleep 4
	iwpriv "$STA_IF" get_site_survey | grep -e "^[0-9]" > /tmp/site_survey
	cat /tmp/site_survey | cut -c5-37 | sed -e "s/ \{1,\}$//" > /tmp/ss_ssids
	if [ "2.4GHz" = "$RADIO" ]; then
		cat /tmp/site_survey | cut -c38- | awk '{print $1";"$3";"$2";2.4GHz"}' > /tmp/ss_data
	elif [ "5GHz" = "$RADIO" ]; then
		cat /tmp/site_survey | cut -c38- | awk '{print $1";"$3";"$2";5GHz"}' > /tmp/ss_data
	fi
	sed -e "s|;OPEN/NONE;|;disabled;|" -e "s|;WPAPSK/TKIP;|;wpa-personal;|" -e "s|;WPA2PSK/AES;|;wpa2-personal;|" -e "s|;WPAPSKWPA2PSK/TKIPAES;|;wpa-mixed;|" -e "s|;WPAPSKWPA2PSK/TKIP;|;wpa-mixed;|" -e "s|;WPAPSKWPA2PSK/AES;|;wpa-mixed;|" -i /tmp/ss_data
	awk '{getline var < "/tmp/ss_data"; print $0";" var}' /tmp/ss_ssids
	rm -f /tmp/ss_ssids
	rm -f /tmp/ss_data
	if [ "down" = `syscfg_get $WLINDEX"_state"` ]; then
		ifconfig $IF down
	fi
	exit
