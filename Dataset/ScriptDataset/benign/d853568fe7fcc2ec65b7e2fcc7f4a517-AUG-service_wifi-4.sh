    APCLI_IF="apcli0 apclii0"
    BRIDGE_MODE=`syscfg_get bridge_mode`
    WIFI_BRIDGE_MODE=`syscfg_get wifi_bridge::mode`
    for VIR_IF in $APCLI_IF; do
        iwpriv $VIR_IF set ApCliEnable=0     2>/dev/null
        iwpriv $VIR_IF set ApCliSsid=        2>/dev/null
        iwpriv $VIR_IF set ApCliBssid=       2>/dev/null
        iwpriv $VIR_IF set ApCliAuthMode=    2>/dev/null
        iwpriv $VIR_IF set ApCliEncrypType=  2>/dev/null
        ifconfig $VIR_IF down 2>/dev/null
    done
	sysevent set wifi_sta_up 0
	if [ "0" != "$BRIDGE_MODE" ] && [ "2" = "$WIFI_BRIDGE_MODE" -o "1" = "$WIFI_BRIDGE_MODE" ]; then
        sysevent set phylink_wan_state down
    fi
