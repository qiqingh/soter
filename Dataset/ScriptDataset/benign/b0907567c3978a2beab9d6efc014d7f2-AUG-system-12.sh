	local mac=$1
	local sep=$2

	echo ${mac:9:2}$sep${mac:12:2}$sep${mac:15:2}
