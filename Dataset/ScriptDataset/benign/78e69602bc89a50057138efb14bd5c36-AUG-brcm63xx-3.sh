	local board_name model

	board_id=$(awk 'BEGIN{FS="[ \t:/]+"} /system type/ {print $4}' /proc/cpuinfo)

	if [ -e /proc/device-tree ]; then
		model=$(cat /proc/device-tree/model)
		board_name=$(brcm63xx_dt_detect "$model")
	else
		model="Unknown bcm63xx board"
		board_name=$(brcm63xx_legacy_detect "$board_id")
	fi

	[ -e "/tmp/sysinfo" ] || mkdir -p "/tmp/sysinfo"

	echo "$board_name" > /tmp/sysinfo/board_name
	echo "$model" > /tmp/sysinfo/model
