	local mac=$1
	local mac_offset=$2
	local chksum_offset=$((mac_offset - 10))

	caldata_patch_mac "$mac" "$mac_offset" "$chksum_offset"
