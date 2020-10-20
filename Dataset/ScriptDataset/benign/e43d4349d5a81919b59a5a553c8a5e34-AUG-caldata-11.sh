	local mac=$1
	local mac_offset=$2
	local chksum_offset=$((mac_offset - 10))
	local target=$4

	caldata_patch_mac "$mac" "$mac_offset" "$chksum_offset" "$target"
