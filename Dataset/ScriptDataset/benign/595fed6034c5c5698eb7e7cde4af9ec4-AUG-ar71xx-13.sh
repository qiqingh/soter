	local size="$(mtd_get_part_size 'firmware')"

	case "$size" in
	8192000)
		AR71XX_MODEL='GL-iNet 6408A v1'
		;;
	16580608)
		AR71XX_MODEL='GL-iNet 6416A v1'
		;;
	esac
