	sync
	if [ "$SAVE_CONFIG" -eq 1 ]; then
		get_image "$1" "$2" | mtd $MTD_ARGS $MTD_CONFIG_ARGS -j "$CONF_TAR" write - "${PART_NAME:-image}"
	else
		get_image "$1" "$2" | mtd $MTD_ARGS write - "${PART_NAME:-image}"
	fi
	[ $? -ne 0 ] && exit 1
