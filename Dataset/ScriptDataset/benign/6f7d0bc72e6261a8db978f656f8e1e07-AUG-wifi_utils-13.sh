	if_name=$1
	cmd_mode=$2
	if [ "$cmd_mode" = "1" ]; then
		iwpriv $if_name set AccessPolicy=0
		iwpriv $if_name set ACLClearAll=1
	fi
	set_wifi_val $if_name AccessPolicy0 0
