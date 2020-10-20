    interface=$1
    ssid="$2"
    passphrase=$3
    wpa=$4
    auth_server_addr=""
    auth_server_port=""
    auth_server_shared_secret=""
    get_wl_index $interface
    CURRENT_INDEX=$?
    wl_index=wl$CURRENT_INDEX
    hw_mode=""
    eap_server=1
    WIFI_FREQ="2.4GHz and 5GHz"
    wpa2_pairwise="wpa_pairwise=CCMP"
    wpa_pairwise="wpa_pairwise=TKIP"
    wpa_mixed_pairwise="wpa_pairwise=CCMP TKIP"
    wpa_key_mgmt="wpa_key_mgmt=WPA-PSK"
    if [ "0" != "$wpa" ]; then
    	wpa_group_rekey="wpa_group_rekey=`syscfg_get $wl_index"_key_renewal"`"
    fi
    if [ "$wpa" = "0" ]; then
        security="wpa=0"
        ieee8021x_set=0  
    else
        if [ "$wpa" = "1" ]; then
            security="wpa=1"$'\n'"$wpa_pairwise"
        elif [ "$wpa" = "2" ]; then
            security="wpa=2"$'\n'"$wpa2_pairwise"
        else
            security="wpa=3"$'\n'"$wpa_mixed_pairwise"
        fi
        ieee8021x_set=0
        security="$security"$'\n'"$passphrase"$'\n'"$wpa_key_mgmt"$'\n'"$wpa_group_rekey"
    fi
	
    if [ "0" = "$CURRENT_INDEX" ]; then
		hw_mode="hw_mode=g"
    elif [ "1" = "$CURRENT_INDEX" ]; then
		hw_mode="hw_mode=a"
    else 
		hw_mode=""
    fi
    cat <<EOF
interface=$interface
bridge=br0
driver=atheros
logger_syslog=127
logger_syslog_level=2
logger_stdout=127
logger_stdout_level=2
$dump_file_line
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0
ssid=$ssid
$hw_mode
macaddr_acl=0
auth_algs=1
ieee8021x=$ieee8021x_set
eapol_key_index_workaround=0
eap_server=$eap_server
$own_ip_addr
$auth_server_addr
$auth_server_port
$auth_server_shared_secret
$security
EOF
