	v "Performing system upgrade..."
	if [ -n "$do_upgrade" ]; then
		eval "$do_upgrade"
	elif type 'platform_do_upgrade' >/dev/null 2>/dev/null; then
		platform_do_upgrade "$IMAGE"
	else
		default_do_upgrade "$IMAGE"
	fi

	if [ "$SAVE_CONFIG" -eq 1 ] && type 'platform_copy_config' >/dev/null 2>/dev/null; then
		platform_copy_config
	fi

	v "Upgrade completed"
	sleep 1

	v "Rebooting system..."
	umount -a
	reboot -f
	sleep 5
	echo b 2>/dev/null >/proc/sysrq-trigger
