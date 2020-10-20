        V_IF=$1
	wl -i $V_IF wsec 0
	wl -i $V_IF wsec_restrict 1
	wl -i $V_IF wpa_auth 0
	wl -i $V_IF eap 0
	wl -i $V_IF auth 0
