	local part=$1
	local offset=$2
	local count=$3
	local mtd

	#. /lib/functions.sh

	mtd=$(find_mtd_part $part)
	[ -n "$mtd" ] || \
		mtk_wifi_e2p_die "no mtd device found for partition $part"

	dd if=$mtd of=/lib/firmware/$FIRMWARE bs=$count skip=$offset count=1 2>/dev/null || \
		mtk_wifi_e2p_die "failed to extract from $mtd"
