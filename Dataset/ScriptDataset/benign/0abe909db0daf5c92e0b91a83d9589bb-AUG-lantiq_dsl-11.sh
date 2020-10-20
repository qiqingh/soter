	local lig
	local vid
	local svid

	lig=$(dsl_cmd g997lig 1)
	vid=$(dsl_string "$lig" G994VendorID)
	svid=$(dsl_string "$lig" SystemVendorID)

	vid=$(parse_vendorid $vid)
	svid=$(parse_vendorid $svid)

	if [ "$action" = "lucistat" ]; then
		echo "dsl.atuc_vendor_id=\"${vid}\""
		echo "dsl.atuc_system_vendor_id=\"${svid}\""
	else
		echo "ATU-C Vendor ID:                          ${vid}"
		echo "ATU-C System Vendor ID:                   ${svid}"
	fi
