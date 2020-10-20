	local length=$1
	local offset=$2

	hexdump -v -n ${length} -s ${offset} -e ''`expr ${length} - 1`'/1 "%02x-" "%02x "' ${factory_mtd}
