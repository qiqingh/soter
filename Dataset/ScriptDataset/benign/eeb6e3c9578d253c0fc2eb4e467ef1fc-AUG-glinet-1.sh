	if [ "$(fw_printenv -n boot_dev 2>/dev/null)" = "on" ] ; then
		>&2 echo "NOTE: boot_dev=on; use switch to control boot partition"
		true
	else
		false
	fi
