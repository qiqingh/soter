	l1dat_exist=`l1dat 2>/dev/null`
	if [ -z "$l1dat_exist" ]; then
		dbg "Layer 1 profile does not exist."
		dbg "Please check l1dat "

		wifi1="ra0"
		wifi1_prefix="ra"
		wifi1_apcli="apcli"
		wifi1_wds="wds"
		wifi1_mesh="mesh"
		wifi2="rai0"
		wifi2_prefix="rai"
		wifi2_apcli="apclii"
		wifi2_wds="wdsi"
		wifi2_mesh="meshi"
		wifi3="rae0"
		wifi3_prefix="rae"
		wifi3_apcli="apclie"
		wifi3_wds="wdse"
		wifi3_mesh="meshe"

	else
		#wifi_if1s=`l1dat idx2if 1`
		#wifi_if2s=`l1dat idx2if 2`
		#wifi_if3s=`l1dat idx2if 3`
		wifi_if1s=`l1dat zone2if dev1`
		wifi_if2s=`l1dat zone2if dev2`
		wifi_if3s=`l1dat zone2if dev3`
	
		wifi1=`echo $wifi_if1s | awk '{print $1}'`
		wifi1_prefix=`echo $wifi_if1s | awk '{print $2}'`
		wifi1_apcli=`echo $wifi_if1s | awk '{print $3}'`
		wifi1_wds=`echo $wifi_if1s | awk '{print $4}'`
		wifi1_mesh=`echo $wifi_if1s | awk '{print $5}'`
	
		wifi2=`echo $wifi_if2s | awk '{print $1}'`
		wifi2_prefix=`echo $wifi_if2s | awk '{print $2}'`
		wifi2_apcli=`echo $wifi_if2s | awk '{print $3}'`
		wifi2_wds=`echo $wifi_if2s | awk '{print $4}'`
		wifi2_mesh=`echo $wifi_if2s | awk '{print $5}'`
	
		wifi3=`echo $wifi_if3s | awk '{print $1}'`
		wifi3_prefix=`echo $wifi_if3s | awk '{print $2}'`
		wifi3_apcli=`echo $wifi_if3s | awk '{print $3}'`
		wifi3_wds=`echo $wifi_if3s | awk '{print $4}'`
		wifi3_mesh=`echo $wifi_if3s | awk '{print $5}'`

		# idx = 0 : not a DBDC interface
		# idx = 1 : main(physical) interface of 1st Wi-Fi band
		# idx > 1 : virtual interface of other Wi-Fi band
		# idx = "": Wi-Fi interface does not exist in l1profile
		wifi1_dbdc_idx=`l1dat if2dbdcidx $wifi1`
		wifi2_dbdc_idx=`l1dat if2dbdcidx $wifi2`
		wifi3_dbdc_idx=`l1dat if2dbdcidx $wifi3`
	fi

	dbg2 "# Wi-Fi interface list"
	dbg2 "\$wifi1=$wifi1"
	dbg2 "\$wifi2=$wifi2"
	dbg2 "\$wifi3=$wifi3"

	RPS_IF_LIST="$RPS_IF_LIST $wifi1 $wifi2 $wifi3"

	gen_vifs_to_rps_if "wifi1_apcli" 1
	gen_vifs_to_rps_if "wifi2_apcli" 1
	gen_vifs_to_rps_if "wifi3_apcli" 1
	gen_vifs_to_rps_if "wifi1_mesh" 1
	gen_vifs_to_rps_if "wifi2_mesh" 1
	gen_vifs_to_rps_if "wifi3_mesh" 1
	gen_vifs_to_rps_if "wifi1_wds" 4
	gen_vifs_to_rps_if "wifi2_wds" 4
	gen_vifs_to_rps_if "wifi3_wds" 4

	scan_wifi_num
