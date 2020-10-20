    interface=$1
    ssid=$2
    wpa=$3
	get_wl_index $interface
	CURRENT_INDEX=$?
	wl_index=wl$CURRENT_INDEX
	ieee8021x_set=1
	eap_server=1
	own_ip_addr="own_ip_addr=`syscfg_get lan_ipaddr`"
	auth_server_addr="auth_server_addr=$4"
	auth_server_port="auth_server_port=$5"
	auth_server_shared_secret="auth_server_shared_secret=$6"
    wpa2_pairwise="wpa_pairwise=CCMP"
    wpa_pairwise="wpa_pairwise=TKIP"
    wpa_mixed_pairwise="wpa_pairwise=CCMP TKIP"
    wpa_key_mgmt="wpa_key_mgmt=WPA-EAP"
	wpa_group_rekey="wpa_group_rekey=`syscfg_get $wl_index"_key_renewal"`"
	if [ "$wpa" = "4" ]; then
		security="wpa=1"$'\n'"$wpa_pairwise"
	elif [ "$wpa" = "5" ]; then
		security="wpa=2"$'\n'"$wpa2_pairwise"
	else
		security="wpa=3"$'\n'"$wpa_mixed_pairwise"
	fi
	security="$security"$'\n'"$passphrase"$'\n'"$wpa_key_mgmt"$'\n'"$wpa_group_rekey"
    cat <<EOF
interface=$interface
bridge=br0
driver=atheros
logger_syslog=127
logger_syslog_level=2
logger_stdout=127
logger_stdout_level=2
$dump_file_line
ssid=$ssid
ieee8021x=$ieee8021x_set
eapol_key_index_workaround=0
$own_ip_addr
$auth_server_addr
$auth_server_port
$auth_server_shared_secret
$security
EOF
