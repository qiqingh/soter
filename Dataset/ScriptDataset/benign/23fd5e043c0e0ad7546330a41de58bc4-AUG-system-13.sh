	local mac=$1

	printf "%02x:%s" $((0x${mac%%:*} | 0x02)) ${mac#*:}
